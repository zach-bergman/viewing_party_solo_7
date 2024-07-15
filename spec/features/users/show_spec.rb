require "rails_helper"

RSpec.describe "User Show/Dashboard Page", type: :feature do
  before(:each) do
    # create users
    @user_1 = User.create!(name: "User 1", email: "user_1@email.com", password: "password1",
    password_confirmation: "password1")
    @user_2 = User.create!(name: "User 2", email: "user_2@email.com", password: "password2",
    password_confirmation: "password2")
    @user_3 = User.create!(name: "User 3", email: "user_3@email.com", password: "password3",
    password_confirmation: "password3")
    @user_4 = User.create!(name: "User 4", email: "user_4@email.com", password: "password4",
    password_confirmation: "password4")

    # create viewing parties
    @party_1 = ViewingParty.create!(date: "2024-12-01", start_time: "07:25", duration: 175, movie_id: 245891)
    @party_2 = ViewingParty.create!(date: "2024-12-01", start_time: "07:25", duration: 175, movie_id: 245891)
    @party_3 = ViewingParty.create!(date: "2024-12-03", start_time: "07:25", duration: 175, movie_id: 458156)
    @party_4 = ViewingParty.create!(date: "2024-12-04", start_time: "07:25", duration: 175, movie_id: 245891)
    @party_5 = ViewingParty.create!(date: "2024-12-04", start_time: "07:25", duration: 175, movie_id: 245891)

    # hosts
    UserParty.create!(user_id: @user_1.id, viewing_party_id: @party_1.id, host: true)
    UserParty.create!(user_id: @user_2.id, viewing_party_id: @party_2.id, host: true)
    UserParty.create!(user_id: @user_3.id, viewing_party_id: @party_3.id, host: true)
    UserParty.create!(user_id: @user_4.id, viewing_party_id: @party_4.id, host: true)
    UserParty.create!(user_id: @user_4.id, viewing_party_id: @party_5.id, host: true)

    # invites for party 1
    UserParty.create!(user_id: @user_2.id, viewing_party_id: @party_1.id, host: false)
    UserParty.create!(user_id: @user_3.id, viewing_party_id: @party_1.id, host: false)

    # invites for party 2
    UserParty.create!(user_id: @user_3.id, viewing_party_id: @party_2.id, host: false)
    UserParty.create!(user_id: @user_4.id, viewing_party_id: @party_2.id, host: false)

    # invites for party 3
    UserParty.create!(user_id: @user_2.id, viewing_party_id: @party_3.id, host: false)
    UserParty.create!(user_id: @user_4.id, viewing_party_id: @party_3.id, host: false)

    # invites for party 4
    UserParty.create!(user_id: @user_1.id, viewing_party_id: @party_4.id, host: false)
    UserParty.create!(user_id: @user_2.id, viewing_party_id: @party_4.id, host: false)
  end

  describe "User Story 7" do
    it "shows the viewing parties the user has been invited to - with movie image, 
      movie title as link to movie show, date, start time, and host - list of users invited, 
      current users name in bold", :vcr do
      visit user_path(@user_2.id)

      within "div.invited_parties" do
        within "div.party_#{@party_1.id}" do
          expect(page).to have_css("img[src*='https://image.tmdb.org/t/p/w200']")
          expect(page).to have_link("John Wick", href: user_movie_path(@user_2.id, 245891))
          expect(page).to have_content("Party Time: #{@party_1.date} at 07:25")
          expect(page).to have_content("Host: #{@user_1.name}")

          within "div.invited_users" do
            expect(page).to have_content(@user_2.name)
            expect(page).to have_content(@user_3.name)
            
            expect(page).to have_css("strong", text: @user_2.name)

            expect(page).to_not have_content(@user_4.name)
          end
        end

        within "div.party_#{@party_3.id}" do
          expect(page).to have_css("img[src*='https://image.tmdb.org/t/p/w200']")
          expect(page).to have_link("John Wick: Chapter 3 - Parabellum", href: user_movie_path(@user_2.id, 458156))
          expect(page).to have_content("Party Time: #{@party_3.date} at 07:25")
          expect(page).to have_content("Host: #{@user_3.name}")

          within "div.invited_users" do
            expect(page).to have_content(@user_2.name)
            expect(page).to have_content(@user_4.name)
            
            expect(page).to have_css("strong", text: @user_2.name)

            expect(page).to_not have_content(@user_1.name)
          end
        end
      end
    end

    it "shows the viewing parties the user has created and is hosting - with movie image, 
      movie title as link to movie show, date, start time, and host - list of users invited, 
      current users name in bold", :vcr do
      visit user_path(@user_2.id)

      within "div.host_parties" do
        within "div.party_#{@party_2.id}" do
          expect(page).to have_css("img[src*='https://image.tmdb.org/t/p/w200']")
          expect(page).to have_link("John Wick", href: user_movie_path(@user_2.id, 245891))
          expect(page).to have_content("Party Time: #{@party_1.date} at 07:25")
          expect(page).to have_content("Host: #{@user_2.name}")

          within "div.invited_users" do
            expect(page).to have_content(@user_3.name)
            expect(page).to have_content(@user_4.name)

            expect(page).to_not have_content(@user_1.name)
          end
        end
      end
    end
  end
end