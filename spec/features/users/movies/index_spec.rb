require "rails_helper"

RSpec.describe "User Movies Index Page", type: :feature do
  describe "User Story 2" do
    it "shows each movies title as a link to movie details page and shows vote average, and 
    shows a button that links to the discover page", :vcr do
      user = User.create!(id: 1, name: "User", email: "user@email.com")

      visit user_discover_index_path(user.id)

      fill_in(:search, with: "Frozen")
      click_button("Search")

      expect(current_path).to eq(user_movies_path(user.id))

      # within "#movie_list" do
        within "#movie_109445_info" do
          expect(page).to have_link("Frozen", href: user_movie_path(user.id, 109445))
          expect(page).to have_content("Vote Average: 7.25")
        end

        within "#movie_967847_info" do
          expect(page).to have_link("Ghostbusters: Frozen Empire", href: user_movie_path(user.id, 967847))
          expect(page).to have_content("Vote Average: 6.7")
        end
      # end

      click_button("Discover Page")

      expect(current_path).to eq(user_discover_index_path(user.id))
    end
  end
end