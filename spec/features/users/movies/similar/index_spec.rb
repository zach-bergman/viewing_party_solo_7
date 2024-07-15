require "rails_helper"

RSpec.describe "Similar Index Page" do
  describe "User Story 6" do
    it "shows a list of similar movies to the movie the user searched for", :vcr do
      user = User.create!(name: 'User', email: "user@email.com", password: "password",
      password_confirmation: "password")

      visit user_movie_similar_index_path(user.id, 245891)

      summary = "A stand-up comedian confesses to a murder on-stage at an open mic night to a shocked audience - his crime the result of a deadly triangle formed between his older sister"

      expect(page).to have_content("Title: Madtown", normalize_ws: true)
      expect(page).to have_content("Summary: #{summary}")
      expect(page).to have_content("Release Date: 2016-03-31")
      expect(page).to have_content("Vote Average: 5.7")

      expect(page).to have_css("img[src*='https://image.tmdb.org/t/p/w200']")
    end
  end
end