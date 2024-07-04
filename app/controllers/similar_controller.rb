class SimilarController < ApplicationController
  def index
    @facade = MovieFacade.new(nil, params[:movie_id])
  end
end