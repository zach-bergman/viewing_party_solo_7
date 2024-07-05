require "rails_helper"

RSpec.describe Movie do
  before(:each) do
    @cast_members = [
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

    attributes = {
      id: 1,
      title: "Napolean Dynamite",
      vote_average: 99.88,
      runtime: 134,
      genres: [{id: 1, name: "Comedy"}, {id: 2, name: "Family"}],
      summary: "Funny stuff",
      overview: nil,
      cast: @cast_members,
      reviews: [{author: "Author", content: "Awesome movie"}],
      release_date: "August",
      poster_path: "pic.jpg"
    }

    @movie = Movie.new(attributes)
  end

  it "exists and has attributes" do
    expect(@movie).to be_a(Movie)
    expect(@movie.id).to eq(1)
    expect(@movie.title).to eq("Napolean Dynamite")
    expect(@movie.vote_average).to eq(99.88)
    expect(@movie.runtime).to eq(134)
    expect(@movie.summary).to eq("Funny stuff")
    expect(@movie.cast).to eq(@cast_members)
    expect(@movie.reviews).to eq([{author: "Author", content: "Awesome movie"}])
    expect(@movie.release_date).to eq("August")
    expect(@movie.poster_path).to eq("pic.jpg")
  end

  describe "#instance_methods" do
    describe "#format_runtime" do
      it "formats the given runtime to hours and minutes" do
        expect(@movie.format_runtime).to eq("2hr 14min")
      end
    end

    describe "#genre_names" do
      it "returns an array of the genre names of the movie" do
        expect(@movie.genre_names).to eq("Comedy, Family")
      end
    end

    describe "#ten_cast_members" do
      it "returns the first ten cast members" do
        expect(@movie.ten_cast_members).to eq(@cast_members[0..9])
      end
    end

    describe "#review_count" do
      it "returns the count of reviews" do
        expect(@movie.review_count).to eq(1)
      end
    end
  end
end