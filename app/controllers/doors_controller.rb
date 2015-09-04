class DoorsController < ApplicationController
  before_action :find_door, only: [:show, :destroy, :edit, :update]
  add_breadcrumb "Lista Drzwi", :doors_path

  def index
  	@door = Door.all
  	@hash = Gmaps4rails.build_markers(@door) do |d, marker|
		  marker.lat d.latitude
		  marker.lng d.longtitude
		  marker.infowindow d.description
		end
  	###############
  	@title = "Index"
  end

  def new
  	@door = Door.new
  	#######################
  	@title = "Utwórz nowe"
  	add_breadcrumb "Utwórz nowe", :new_door_path
  end

  def create
  	@door = Door.new(door_params)

  	if @door.save
  		redirect_to doors_path
		else 
			render 'new'  		
  	end
  end

  def show
  	add_breadcrumb "Przegląd", door_path(@door)
  	#######################
  	@title = "Przegląd"
  end

  def edit
  	add_breadcrumb "Edytuj", :edit_door_path
  	#######################
  	@title = "Edytuj"
  end

  def update
  	if @door.update(door_params)
  		redirect_to door_path(@door)
  	else
  		render 'edit'
  	end
  end

  def destroy
  	@door.destroy
  	redirect_to doors_path
  end

  private

  	def door_params
  		params.require(:door).permit(:title, :address, :description)
  	end

  	def find_door
	  	@door = Door.find(params[:id])
  	end
end
