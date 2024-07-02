require "rails_helper"

RSpec.describe MovieFacade do
  it "exists and has a search attribute" do
    facade = MovieFacade.new("Frozen")

    expect(facade).to be_a(MovieFacade)
    expect(facade.instance_variable_get(:@search)).to eq("Frozen")
  end

  it "returns an array of Movie objects", :vcr do
    facade = MovieFacade.new("Frozen")

    expect(facade.movies).to be_an(Array)
    facade.movies.each do |movie|
      expect(movie).to be_a(Movie)
    end
  end
end