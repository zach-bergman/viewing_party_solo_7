require "rails_helper"

RSpec.describe "Movie Show Page" do
  describe "User Story 3" do
    it "shows a button to create a viewing party", :vcr do
      user = User.create!(id: 1, name: "User", email: "user@email.com")

      visit user_movie_path(user.id, 245891)

      within "div.buttons" do
        click_button("Create Viewing Party for John Wick")
      end

      expect(current_path).to eq(new_user_movie_viewing_party_path(user_id: user.id, movie_id: 245891))
    end

    it "shows a button that links back to Discover Page", :vcr do
      user = User.create!(id: 1, name: "User", email: "user@email.com")

      visit user_movie_path(user.id, 245891)

      within "div.buttons" do
        click_button("Discover Page")
      end

      expect(current_path).to eq(user_discover_index_path(user.id))
    end

    it "shows the title, vote average, runtime in hours and minutes, genres, summary, 
      first 10 cast members, count of total reviews, each reviews author and info", :vcr do
      user = User.create!(id: 1, name: "User", email: "user@email.com")

      visit user_movie_path(user.id, 245891)

      expect(page).to have_content("John Wick")

      overview = "Ex-hitman John Wick comes out of retirement to track down the gangsters that took everything from him."

      within "div.movie_info" do
        expect(page).to have_content("Vote Average: 7.43")
        expect(page).to have_content("Runtime: 1 hours 41 minutes")
        expect(page).to have_content("Genre: Action, Thriller")
        expect(page).to have_content("Summary: #{overview}")
      end

      within "div.cast_info" do
        expect(page).to have_content("Name: Keanu Reeves")
        expect(page).to have_content("Character: John Wick")

        expect(page).to have_content("Name: Michael Nyqvist")
        expect(page).to have_content("Character: Viggo Tarasov")

        expect(page).to have_content("Name: Alfie Allen")
        expect(page).to have_content("Character: Iosef Tarasov")

        expect(page).to have_content("Name:", maximum: 10)
      end

      review_1 = "This is very much my kind of movie."
      review_2 = "It's cheesy, formulaic, and hammily acted."

      within "div.reviews" do
        expect(page).to have_content("Total Reviews: 13")
        expect(page).to have_content("Author: Per Gunnar Jonsson")
        expect(page).to have_content("Review: #{review_1}")
        expect(page).to have_content("Author: Sheldon Nylander") 
        expect(page).to have_content("Review: #{review_2}")
      end
    end
  end
end