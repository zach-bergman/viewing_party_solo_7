class MovieService
  def conn
    Faraday.new(url: "https://api.themoviedb.org/3/") do |faraday|
      faraday.params["api_key"] = Rails.application.credentials.tmdb[:key]
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def movie_search(search)
    get_url("search/movie?query=#{search}")[:results]
  end

  def find_movie_by_id(id)
    get_url("movie/#{id}?append_to_response=credits,reviews")
  end
end