require 'rails_helper'

RSpec.describe 'Root Page, Welcome Index', type: :feature do
  describe 'When a user visits the root path "/"' do
    before(:each) do
      @user_1 = User.create!(name: 'Sam', email: 'sam_t@email.com', password: "password",
      password_confirmation: "password")
      @user_2 = User.create!(name: 'Tommy', email: 'tommy_t@gmail.com', password: "password2",
      password_confirmation: "password2")
      @user_3 = User.create!(name: 'Billy', email: 'billy_b@gmail.com', password: "password3",
      password_confirmation: "password3")

      visit root_path
    end

    it 'They see title of application, and link back to home page' do
      expect(page).to have_content('Viewing Party')
      expect(page).to have_link('Home')
    end

    describe "when user is logged in" do
      it "They see a welcome message, and list of existing users" do
        visit login_path

        fill_in :email, with: @user_1.email
        fill_in :password, with: @user_1.password
        fill_in :password_confirmation, with: @user_1.password_confirmation
        fill_in :location, with: "Denver, CO"

        click_button "Log In"

        visit root_path

        expect(page).to have_content("Welcome, Sam!")
        expect(page).to have_content("Existing Users")

        within "#existing_users" do
          expect(page).to have_content(@user_2.email)
          expect(page).to have_content(@user_3.email)
        end
      end
    end

    describe "when user is not logged in" do
      it "does not show list of existing users" do
        expect(page).to_not have_content("Existing Users")        
        expect(page).to_not have_content(@user_1.email)
        expect(page).to_not have_content(@user_2.email)
        expect(page).to_not have_content(@user_3.email)
      end

      it "cannot view a user dashboard unless logged in" do
        visit user_path(@user_1)
        expect(page).to have_content("You must be logged in or registered to view this page")
      end
    end

    it 'They see button to create a New User' do
      expect(page).to have_selector(:link_or_button, 'Create New User')
    end

    it "They see a link to go back to the landing page (present at the top of all pages)" do
      expect(page).to have_link("Home")
    end
  end
end
