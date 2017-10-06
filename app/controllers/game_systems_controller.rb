class GameSystemsController < ApplicationController

  def index
    @game_systems = GameSystem.all
    respond_to do |f|
      f.html
      f.json { json_response(@game_systems) }
    end
  end

  def show
    @game_system = GameSystem.find(params[:id])
    @sections = @game_system.sections
    @characters = @game_system.characters
    render 'show'
  end

  def new
    @game_system = GameSystem.new
    @sections = []
  end

  def create
    @game_system = GameSystem.create!(game_system_params)
    redirect_to game_system_path @game_system
  end

  def edit
    @game_system = GameSystem.find(params[:id])
    @sections = @game_system.sections
  end

  def update
    @game_system = GameSystem.find(params[:id])
    @game_system.update!(game_system_params)
    redirect_to game_system_path @game_system
  end

  def destroy
    @game_system = GameSystem.find(params[:id])
    if @game_system.destroy
      redirect_to game_systems_path
    end
  end

private
  def game_system_params
    params.permit(:name, :publisher, :description, :slug, sections: [])
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
