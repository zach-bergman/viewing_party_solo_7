require "rails_helper"

RSpec.describe "Viewing Party Show Page" do
  describe "User Story 5" do
    it "shows logos of video providers to buy or rent the movie, 
      and data attribution for JustWatch platform", :vcr do
      user = User.create!(name: 'User', email: "user@email.com", password: "password",
      password_confirmation: "password")

      party_data = {
        duration: 130,
        date: Date.tomorrow,
        start_time: "17:00",
        movie_id: 245891
      }

      party = ViewingParty.create!(party_data)

      visit user_movie_viewing_party_path(user.id, 245891, party.id)

      within "div.buy_movie" do
        expect(page).to have_css("img[src*='https://image.tmdb.org/t/p/w200']")
        expect(page).to have_content("Buy: ")
      end

      within "div.rent_movie" do
        expect(page).to have_css("img[src*='https://image.tmdb.org/t/p/w200']")
        expect(page).to have_content("Rent: ")
      end

      expect(page).to have_content("Buy/Rent data provided by JustWatch")
    end
  end
end