require 'net/http'
require 'net/https'
require 'json'

class DoorsController < ApplicationController
  before_action :find_door, only: [:show, :destroy, :edit, :update]
  before_action :street_only, only: [:show]
  before_action :protect, only: [:edit, :new, :destroy]
  helper_method :imgur
  # add_breadcrumb "Lista Drzwi", :doors_path

  def index
  	@door = Door.all
  	@hash = create_markers(@door)
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
      respond_to do |format|
        format.html { redirect_to doors_path }
        format.js { render 'index' }
      end
    else 
      render 'new'      
    end
  end

  def show
  	add_breadcrumb "Przegląd", door_path(@door)
  	@door_all = Door.all
  	@hash = create_markers(@door_all)
  	@hash_single = create_markers(@door)
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
  		# redirect_to door_path(@door)
      respond_to do |format|
        format.html { redirect_to door_path(@door) }
        format.js
      end
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
  		if current_user.nil?
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

  	def create_markers(doors)
	  	hash = Gmaps4rails.build_markers(doors) do |d, marker|
			  marker.lat d.latitude
			  marker.lng d.longitude
			  marker.infowindow generate_info_window(d)
			end
			return hash
  	end

  	def generate_info_window(door)
  		info = "<div><b>#{door.address}</b><br/>Super drzwi<br/><a href='/doors/#{door.id}'>Zobacz więcej</a></div><div align='right'><img src='#{door.image}' width='70' height='80'/></div>"
  	end

    def imgur#(album_id)     
      # puts "Let's get some pics"

      headers    = {
        "Authorization" => "Client-ID 71d7078461a9c27"
      }

      #http       = Net::HTTP.new("https://api.imgur.com")
      path       = "/3/album/#{@door.image}.json"
      uri = URI.parse("https://api.imgur.com"+path)
      request, data = Net::HTTP::Get.new(path, headers)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.request(request)
      # puts response.body
      parsed = JSON.parse(response.body.to_s)
      # puts '********************'
      # parsed["data"]["images"].each do |img|
      #   puts "#{img['datetime']}, #{img['title']}, #{img['description']}"
      # end
 #     parsed["data"]["images"][0]["id"]  #alternatywne wybieranie z tablicy elementów
    end
end
