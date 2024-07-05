class MovieFacade
  attr_reader :movie

  def initialize(search = nil, id = nil)
    @search = search
    @service = MovieService.new
    @id = id
    @movie = find_movie_by_id
  end
  
  def movies
    results = (@search.nil? ? @service.get_top_rated_movies : @service.movie_search(@search))
    
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

  def buy_movie_from_providers
    @service.get_movie_providers(@id)[:buy]
  end

  def rent_movie_from_providers
    @service.get_movie_providers(@id)[:rent]
  end

  def similar_movies
    results = @service.get_similar_movies(@id)

    results.map do |movie_data| 
      data = @service.find_movie_by_id(movie_data[:id])

      Movie.new(format_movie_data(data))
    end
  end

  def image_begin_url
    "https://image.tmdb.org/t/p/w200"
  end
end