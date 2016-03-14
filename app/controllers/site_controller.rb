class SiteController < ApplicationController

  def index
    @title = "Strona główna"
  end

  def doors
    @title = "Drzwi"
    add_breadcrumb "#{@title}", :site_doors_path
  end

  def about
    @title = "O nas"
    add_breadcrumb "#{@title}", :site_about_path
  end

  def about_project
    @title = "O projekcie"
    add_breadcrumb "#{@title}", :site_about_project_path
  end

  def news
    @title = "Aktualności"
    add_breadcrumb "#{@title}", :site_news_path
  end

  def help
    @title = "Pomoc"
    add_breadcrumb "#{@title}", :site_help_path 
  end
end
