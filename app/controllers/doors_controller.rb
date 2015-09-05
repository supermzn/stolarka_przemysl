class DoorsController < ApplicationController
  before_action :find_door, only: [:show, :destroy, :edit, :update]
  before_action :street_only, only: [:show]
  before_action :protect, only: [:edit]
  add_breadcrumb "Lista Drzwi", :doors_path

  def index
  	@door = Door.all
  	@hash = Gmaps4rails.build_markers(@door) do |d, marker|
		  marker.lat d.latitude
		  marker.lng d.longitude
		  marker.infowindow generate_info_window(d)
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
  		params.require(:door).permit(:title, :address, :description, :longitude, :latitude, :image)
  	end

  	def protect
  		unless current_user
  			flash[:notice] = "Proszę się zalogować!"
  			redirect_to doors_path
  			return false
  		end
  	end

  	# cuts off city part needed for geocoder and unwanted for user
  	# example: "Ottery St Catchpole 13, Devon" => "Ottery St Catchpole 13"
		def street_only
			@door.address = @door.address.partition(",")[0]		
		end

  	def find_door
	  	@door = Door.find(params[:id])
  	end

  	def generate_info_window(door)
  		info = "<div><b>#{door.address}</b><br/>Super drzwi<br/><a href='doors/#{door.id}'>Zobacz więcej</a></div><div align='right'><img src='/images/doors/#{door.image}' width='70' height='80'/></div>"
  	end
end
