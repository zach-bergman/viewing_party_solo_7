class Admin::DashboardController < ApplicationController
  before_action :require_admin, only: [:index]

  def index
      @users = User.default_users
  end

  private
  def require_admin
    if !current_admin?
      flash[:error] = "You're not authorized to access this page."
      redirect_to root_path
    end
  end
end