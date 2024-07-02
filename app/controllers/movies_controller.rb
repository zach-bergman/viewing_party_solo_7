class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @facade =
      if params[:search]
        MovieFacade.new(params[:search])
      else
        MovieFacade.new
      end
  end
end