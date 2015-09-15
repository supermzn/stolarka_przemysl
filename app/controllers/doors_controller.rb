require 'xml/xslt'
require 'rexml/document'

class DoorsController < ApplicationController
  before_action :find_door, only: [:show, :destroy, :edit, :update]
  before_action :protect, only: [:edit, :new, :destroy]
  add_breadcrumb "Lista Drzwi", :doors_path

  def index
  	xslt = XML::XSLT.new # utworzenie obiektu typu xslt
  	# dodanie do xslt plików xml i xsl
  	xslt.xml = "app/views/doors/doors.xml" 
  	xslt.xsl = "app/views/doors/xsl_index.xsl"
  	# zapis do pliku "index.html.erb" wyniku transformacji metodą serve
  	IO.write("app/views/doors/index.html.erb", xslt.serve)

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
  		doors_to_xml
      respond_to do |format|
    		format.html { redirect_to doors_path }
        format.js { render 'index' }
      end
		else 
			render 'new'  		
  	end
  end

  def show
    create_single_door_xml(@door.id)
    xslt = XML::XSLT.new # utworzenie obiektu typu xslt
    # dodanie do xslt plików xml i xsl
    xslt.xml = "app/views/doors/single_door.xml" 
    xslt.xsl = "app/views/doors/xsl_show.xsl"
    # zapis do pliku "show.html.erb" wyniku transformacji metodą serve
    IO.write("app/views/doors/show.html.erb", xslt.serve)

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
  		doors_to_xml
      respond_to do |format|
        format.html { redirect_to doors_path }
        format.js { doors_to_xml}
      end
  	else
  		render 'edit'
  	end
  end

  def destroy
  	@door.destroy
    doors_to_xml
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
  		info = "<div><b>#{door.address}</b><br/><a href='/doors/#{door.id}'>Zobacz więcej</a></div><div align='right'><img src='#{door.image}' width='70' height='80'/></div>"
  	end

  	def doors_to_xml
	  	@door_all = Door.all
	  	door_xml = @door_all.to_xml
	  	IO.write("app/views/doors/doors.xml", door_xml)  		
  	end

    def create_single_door_xml door_id
      file = File.open 'app/views/doors/doors.xml'
      myxml = REXML::Document.new file
      door = myxml.elements["doors/door[id='#{door_id}']"]
      xml_top = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
      IO.write("app/views/doors/single_door.xml", xml_top + door.to_s)
    end
end
