class SessionController < ApplicationController
  def new

  end

  def create
    @user = User.find_by(login: params[:session][:login])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Witaj użytkowniku #{current_user.login}"
      redirect_to '/session/index'
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

  def index

  end
end
