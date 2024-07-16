class Admin::UsersController < ApplicationController
  before_action :require_admin, only: [:show]

  def show
    @user = User.find(params[:id])
    @facade = MovieFacade.new
  end

  private
  def require_admin
    if !current_admin?
      flash[:error] = "You're not authorized to access this page."
      redirect_to root_path
    end
  end
end