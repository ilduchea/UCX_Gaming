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
    @character = Character.new
    @sections = []
    render "characters/#{@gs.slug}/new"
  end

  def create
    @character = Character.create!(character_params)
    redirect_to 'index'
  end

  def edit
    @character = Character.find(params[:id])
    @sections = @character.sections
  end

  def update
    @character = Character.find(params[:id])
    @character.update!(character_params)
    redirect_to 'index'
  end

  def destroy
    @character = Character.find(params[:id])
    if @character.destroy
      redirect_to 'index'
    end
  end

private
  def character_params
    params.permit(:name, :publisher, :description, sections: [])
  end

  def create_sections sections, gs
    sections.each do |section|
      gs.sections.push section
      create_child_sections section
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
