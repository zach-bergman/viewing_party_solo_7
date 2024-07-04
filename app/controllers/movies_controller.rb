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

  def show
    @facade = MovieFacade.new(nil, params[:id])
    @user = User.find(params[:user_id])
  end
end