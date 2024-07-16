class UsersController < ApplicationController
   before_action :require_user, only: [:show]

   def new
      @user = User.new
   end

   def show
      @user = User.find(params[:id])
      @facade = MovieFacade.new
   end

   def create
      user = User.create(user_params)
      if user.save
         session[:user_id] = user.id
         flash[:success] = 'Successfully Created New User'
         redirect_to user_path(user)
      else
         flash[:error] = "#{error_message(user.errors)}"
         redirect_to :register_user
      end   
   end

   private
   def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
   end

   def require_user
      if !current_user
         flash[:error] = 'You must be logged in or registered to view this page'
         redirect_to root_path
      end
   end
end