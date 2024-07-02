require "rails_helper"

RSpec.describe Movie do
  before(:each) do
    attributes = {
      id: 1,
      title: "Napolean Dynamite",
      vote_average: 99.88,
      runtime: 134,
      genres: [{id: 1, name: "Comedy"}],
      summary: "Funny stuff",
      cast: [{name: "Actor", character: "ND"}],
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
    expect(@movie.cast).to eq([{name: "Actor", character: "ND"}])
    expect(@movie.reviews).to eq([{author: "Author", content: "Awesome movie"}])
    expect(@movie.release_date).to eq("August")
    expect(@movie.poster_path).to eq("pic.jpg")
  end
end