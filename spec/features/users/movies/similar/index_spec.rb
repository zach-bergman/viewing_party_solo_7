require "rails_helper"

RSpec.describe "Similar Index Page" do
  describe "User Story 6" do
    it "shows a list of similar movies to the movie the user searched for", :vcr do
      user = User.create!(name: 'User', email: "user@email.com")

      visit user_movie_similar_index_path(user.id, 245891)

      summary = "A hacker who is spying on a pretty neighbour messes up his assignment to break into Swiss bank accounts for Russian mobsters."

      expect(page).to have_content("Title: Nicotina", normalize_ws: true)
      expect(page).to have_content("Summary: #{summary}")
      expect(page).to have_content("Release Date: 2003-10-03")
      expect(page).to have_content("Vote Average: 6.45")

      expect(page).to have_css("img[src*='https://image.tmdb.org/t/p/w200']")
    end
  end
end