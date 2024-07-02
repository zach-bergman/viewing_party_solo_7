require "rails_helper"

RSpec.describe "User Discover Movies Page", type: :feature do
  describe "User Story 1" do
    it "shows a button to discover top rated movies, a text field to enter keyword(s) to search by movie title, a button to search by movie title", :vcr do
      user = User.create!(id: 1, name: "User", email: "user@email.com")
      visit user_discover_index_path(user.id)

      expect(page).to have_button("Discover Top Rated Movies")
      expect(page).to have_button("Search")
      fill_in(:search, with: "Frozen")
      click_button("Search")

      expect(current_path).to eq(user_movies_path(user.id))

      visit user_discover_index_path(user.id)

      click_button("Discover Top Rated Movies")

      expect(current_path).to eq(user_movies_path(user.id))
    end
  end
end