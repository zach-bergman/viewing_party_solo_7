require "rails_helper"

RSpec.describe "Viewing Party New Page", type: :feature do
  describe "User Story 4" do
    it "has movie title - above a form to create a new viewing party with correct form fields
    - duration of party, date, start time, guests, and button to create the party", :vcr do
      user = User.create!(id: 1, name: "User", email: "user@email.com")
      user_2 = User.create!(id: 2, name: "User 2", email: "user2@email.com")
      user_3 = User.create!(id: 3, name: "User 3", email: "user3@email.com")

      visit new_user_movie_viewing_party_path(user.id, 245891)

      within "div.create_party_form" do
        expect(page).to have_content("Title: John Wick")
        expect(page).to have_field("Duration:", with: "101")
        
        fill_in(:duration, with: "130")
        fill_in(:date, with: Date.tomorrow)
        fill_in(:start_time, with: "19:00")
        fill_in(:guest_1_email, with: user.email)
        fill_in(:guest_2_email, with: user_2.email)
        fill_in(:guest_3_email, with: user_3.email)

        click_button("Create Viewing Party")
      end

      expect(current_path).to eq(user_path(user.id))
    end
  end
end