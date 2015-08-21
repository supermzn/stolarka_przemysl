class SiteController < ApplicationController

  def index
    @title = "Home"
  end

  def doors
    @title = "Drzwi"
    add_breadcrumb "#{@title}", :site_doors_path
  end

  def about
    @title = "O nas"
    add_breadcrumb "#{@title}", :site_about_path
  end

  def help
    @title = "Pomoc"
    add_breadcrumb "#{@title}", :site_help_path 
  end
end
