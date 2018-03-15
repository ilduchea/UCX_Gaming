class CharactersController < ApplicationController

  def index
    @characters = Character.all
    respond_to do |f|
      f.html
      f.json { json_response(@characters) }
    end
  end

  def show
    @character = Character.find(params[:id])
    @sections = @character.sections
    respond_to do |f|
      f.html
      f.json { json_response(@character) }
    end
  end

  def new
    @gs = GameSystem.find(params[:game_system_id])
    @gs_sections = @gs.sections
    @character = Character.set_new_char @gs
    @sections = @character.sections
    render "characters/#{@gs.slug}/new"
  end

  def create
    @gs = GameSystem.find(params[:game_system_id])
    sections = params[:sections]
    @character = @gs.characters.create(cs_info)
    create_sections sections, @character
    @character.save
    redirect_to game_system_path @gs
  end

  def edit
    @gs = GameSystem.find(params[:game_system_id])
    @gs_sections = @gs.sections
    @character = Character.find(params[:id])
    @sections = @character.sections
    render "characters/#{@gs.slug}/edit"
  end

  def update
    @gs = GameSystem.find(params[:game_system_id])
    @character = Character.find(params[:id])
    @character.update!(cs_info)
    respond_to do |f|
      f.html { redirect_to game_system_path @gs }
      # f.js { "window.location = 'game_systems/#{@gs.id}" }
    end
  end

  def destroy
    @character = Character.find(params[:id])
    if @character.destroy
      redirect_to game_system_path params[:game_system_id]
    end
  end

private
  def character_params
    params.permit(:game_system_id, :name, :player_name, sections: []).merge(get_cs_params)
  end

  def cs_info
    {
      name: params['name'],
      player_name: params['player_name']
    }.merge(get_cs_info params)
  end

  def get_cs_params
    reg_ex = /(\bcs_)\w*/
    cs_params = []
    params.each_pair do |k, v|
      reg_ex.match(k) { cs_params << k }
    end
    cs_params
  end

  def get_cs_info h
    reg_ex = /(\bcs_)\w*/
    cs_info = {}
    h.each_pair do |k, v|
      reg_ex.match(k) {
        cs_info.merge!({k => JSON.parse(v.to_json)})
      }
    end
    cs_info
  end

  def create_sections sections, h
    sections.each do |section|
      s = JSON.parse(section.to_json)
      s['sectional_type'] = nil
      s['sectional_id'] = nil
      newSection = Section.new(s)
      h.sections.push newSection
    end
  end

  def create_child_sections section
    section.child_sections.each do |child|
      child.traits.each { |trait| child.traits.push trait }
      create_child_sections child
      section.child_sections.push child
    end
  end
end
