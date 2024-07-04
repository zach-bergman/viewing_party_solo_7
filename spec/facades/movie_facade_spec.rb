require "rails_helper"

RSpec.describe MovieFacade do
  it "exists with no arguments passed" do
    facade = MovieFacade.new

    expect(facade).to be_a(MovieFacade)
    expect(facade.instance_variable_get(:@movie)).to be nil
  end

  it "exists and has attributes if passed during instantiation" do
    facade = MovieFacade.new("Frozen", 109445)

    expect(facade).to be_a(MovieFacade)
    expect(facade.instance_variable_get(:@search)).to eq("Frozen")
    expect(facade.instance_variable_get(:@id)).to eq(109445)
  end

  describe "#movies" do
    it "returns an array of Movie objects", :vcr do
      facade = MovieFacade.new("Frozen")

      expect(facade.movies).to be_an(Array)

      facade.movies.each do |movie|
        expect(movie).to be_a(Movie)
      end
    end
  end

  describe "#find_movie_by_id" do
    it "creates a new Movie object", :vcr do
      facade = MovieFacade.new(nil, 109445)

      frozen = facade.find_movie_by_id

      expect(frozen).to be_a(Movie)
    end
  end

  describe "#format_movie_data" do
    it "reformats data given by the MovieService so it can be used to create new Movie object" do
      facade = MovieFacade.new

      cast_members = [
      { name: "Actor 1", character: "Character 1" },
      { name: "Actor 2", character: "Character 2" },
      { name: "Actor 3", character: "Character 3" },
      { name: "Actor 4", character: "Character 4" },
      { name: "Actor 5", character: "Character 5" },
      { name: "Actor 6", character: "Character 6" },
      { name: "Actor 7", character: "Character 7" },
      { name: "Actor 8", character: "Character 8" },
      { name: "Actor 9", character: "Character 9" },
      { name: "Actor 10", character: "Character 10" },
      { name: "Actor 11", character: "Character 11" }
    ]

      data = {
        id: 1,
        title: "Title",
        vote_average: 7.2,
        runtime: 102,
        genres: [{:id=>16, :name=>"Animation"}, {:id=>10751, :name=>"Family"}, {:id=>12, :name=>"Adventure"}, {:id=>14, :name=>"Fantasy"}],
        summary: "Great stuff right here.",
        credits: {cast: cast_members},
        reviews: {results: "Amazing reviews here."},
        release_date: "2013-11-20",
        poster_path: "/itAKcobTYGpYT8Phwjd8c9hleTo.jpg"
      }

      expect(facade.format_movie_data(data)).to have_key(:id)
      expect(facade.format_movie_data(data)).to have_key(:title)
      expect(facade.format_movie_data(data)).to have_key(:vote_average)
      expect(facade.format_movie_data(data)).to have_key(:runtime)
      expect(facade.format_movie_data(data)).to have_key(:genres)
      expect(facade.format_movie_data(data)).to have_key(:summary)
      expect(facade.format_movie_data(data)).to have_key(:cast)
      expect(facade.format_movie_data(data)).to have_key(:reviews)
      expect(facade.format_movie_data(data)).to have_key(:release_date)
      expect(facade.format_movie_data(data)).to have_key(:poster_path)
    end
  end
end