class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      cookies.encrypted[:location] = session_params[:location]
      flash[:success] = "Welcome, #{user.name}!"
      if user.admin?
        redirect_to admin_dashboard_index_path
      elsif 
        redirect_to user_path(user)
      end
    else
      flash[:error] = 'Invalid Credentials'
      render :new
    end
  end

  def destroy
    session.destroy

    redirect_to root_path
    flash[:success] = 'Successfully Logged Out'
  end

  private
  def session_params
    params.permit(:email, :password, :location, :role)
  end
end