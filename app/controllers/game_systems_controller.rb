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
    respond_to do |f|
      f.html
      f.json { json_response(@game_system) }
    end
  end

  def new
    @game_system = GameSystem.new
  end

  def create
    @game_system = GameSystem.create!(game_system_params)
    render index
  end

  def edit
    @game_system = GameSystem.find(params[:id])
  end

  def update
    @game_system = GameSystem.find(params[:id])
    binding.pry
  end

  def destroy
    @game_system = GameSystem.find(params[:id])
    if @game_system.destroy
      render status: 200, json: {
        message: "Your game system has been deleted."
      }
    end
  end

private
  def game_system_params
    params.permit(:name, :publisher, :description, :sections)
  end
end
