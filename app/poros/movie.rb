class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :runtime,
              :genres,
              :summary,
              :cast,
              :reviews,
              :release_date,
              :poster_path

  def initialize(attributes)
    @id = attributes[:id].to_i
    @title = attributes[:title]
    @vote_average = attributes[:vote_average]
    @runtime = attributes[:runtime]
    @genres = attributes[:genres]
    @summary = attributes[:summary]
    @cast = attributes[:cast]
    @reviews = attributes[:reviews]
    @release_date = attributes[:release_date]
    @poster_path = attributes[:poster_path]
  end
end