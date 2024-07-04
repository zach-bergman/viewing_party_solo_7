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

  def initialize(attributes) # do i need all of this data?
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

  def format_runtime
    "#{@runtime / 60} hours #{@runtime % 60} minutes"
  end

  def genre_names
    @genres.map { |genre| genre[:name] }.join(", ")
  end

  def ten_cast_members
    @cast[0..9]
  end
  
  def review_count
    @reviews.count
  end

  # def review_maker
  #   @reviews.map do |review|
  #     binding.pry
  #   end
  # end
end