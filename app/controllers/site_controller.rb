class SiteController < ApplicationController
  def index
    @title = "Home"
  end

  def doors
    @title = "Drzwi"
  end

  def about
    @title = "O nas"
  end

  def help
    @title = "Pomoc"
  end
end
