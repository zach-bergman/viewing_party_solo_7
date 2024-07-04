class MovieFacade
  attr_reader :movie

  def initialize(search = nil, id = nil)
    @search = search
    @service = MovieService.new
    @id = id
    @movie = find_movie_by_id
  end
  
  def movies
    results = @service.movie_search(@search)
    
    movies = results.map { |movie_data| Movie.new(movie_data) }
    
    movies.compact[0..19]
  end
  
  def find_movie_by_id
    if @id
      movie_data = @service.find_movie_by_id(@id)
      
      Movie.new(format_movie_data(movie_data))
    end
  end

  def format_movie_data(movie_data)
    {
      id: movie_data[:id],
      title: movie_data[:title],
      vote_average: movie_data[:vote_average],
      runtime: movie_data[:runtime],
      genres: movie_data[:genres],
      summary: movie_data[:overview],
      cast: movie_data[:credits][:cast],
      reviews: movie_data[:reviews][:results],
      release_date: movie_data[:release_date],
      poster_path: movie_data[:poster_path],
    }
  end
end