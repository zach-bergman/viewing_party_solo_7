class MovieFacade

  def initialize(search = nil)
    @search = search
    @service = MovieService.new
  end

  def movies
    results = @service.movie_search(@search)
    
    results.map { |movie_data| Movie.new(movie_data) }
  end
end