class DoorsController < ApplicationController
  def new
  	@door = Door.new
  end

  def create
  	@door = Door.new(door_params)

  	if @door.save
  		redirect_to root_path
		else 
			render 'new'  		
  	end
  end

  def show
  	@door = Door.all
  end

  private

  	def door_params
  		params.require(:door).permit(:title, :address, :description)
  	end
end
