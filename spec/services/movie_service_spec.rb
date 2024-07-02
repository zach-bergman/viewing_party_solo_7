require "rails_helper"

RSpec.describe "Movie Service" do
  describe "initialize" do
    it "exists" do
      service = MovieService.new
  
      expect(service).to be_a MovieService
    end
  end

  describe "#conn" do
    it "creates a Faraday connection" do
      connection = MovieService.new.conn

      expect(connection).to be_a Faraday::Connection
    end
  end

  describe "#get_url", :vcr do
    it "returns the results from the API call" do
      response = MovieService.new.get_url("movie/top_rated")

      expect(response).to be_a Hash

      expect(response).to have_key(:page)
      expect(response[:page]).to be_an Integer

      expect(response).to have_key(:results)
      expect(response[:results]).to be_an Array

      expect(response).to have_key(:total_pages)
      expect(response[:total_pages]).to be_an Integer

      expect(response).to have_key(:total_results)
      expect(response[:total_results]).to be_an Integer
    end
  end

  describe "#movie_search" do
    it "returns an array of movies with a title that included searched words", :vcr do
      movies = MovieService.new.movie_search("John Wick")

      expect(movies).to be_a Array

      movies.each do |movie|
        expect(movie[:title]).to include("John Wick")
        expect(movie).to have_key(:title)
        expect(movie).to have_key(:vote_average)
      end
    end
  end
end