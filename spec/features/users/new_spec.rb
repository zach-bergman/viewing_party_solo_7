require 'rails_helper'

RSpec.describe 'Create New User', type: :feature do
  describe 'When user visits "/register"' do
    before(:each) do
      @user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "password",
      password_confirmation: "password")
      @user = User.create!(name: 'Sam', email: 'sam@email.com', password: "password2",
      password_confirmation: "password2")

      visit register_user_path
    end
    
    it 'They see a Home link that redirects to landing page' do

      expect(page).to have_link('Home')

      click_link "Home"

      expect(current_path).to eq(root_path)
    end
    
    it 'They see a form to fill in their name, email, password, and password confirmation' do
      expect(page).to have_field("user[name]")
      expect(page).to have_field('user[email]')
      expect(page).to have_field('user[password]')
      expect(page).to have_field('user[password_confirmation]')
      expect(page).to have_selector(:link_or_button, 'Create New User')    
    end
    
    it 'When they fill in the form with their name and email then they are taken to their dashboard page "/users/:id"' do
      fill_in "user[name]", with: 'Chris'
      fill_in "user[email]", with: 'chris@email.com'
      fill_in "user[password]", with: 'password'
      fill_in "user[password_confirmation]", with: 'password'

      click_button 'Create New User'
    
      new_user = User.last

      expect(current_path).to eq(user_path(new_user))
      expect(page).to have_content('Successfully Created New User')
    end

    it 'when they fill in form with information, email (non-unique), submit, redirects to user show page' do
      fill_in "user[name]", with: 'Tommy'
      fill_in "user[email]", with: 'tommy@email.com'
      fill_in "user[password]", with: 'password'
      fill_in "user[password_confirmation]", with: 'password'

      click_button 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content('Email has already been taken')
    end

    it 'when they fill in form with missing information' do
      fill_in "user[name]", with: ""
      fill_in "user[email]", with: ""
      fill_in "user[password]", with: ""
      fill_in "user[password_confirmation]", with: ""

      click_button 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content("Name can't be blank, Email can't be blank")
    end

    it 'They fill in form with invalid email format (only somethng@something.something)' do 
      fill_in "user[name]", with: "Sam"
      fill_in "user[email]", with: "sam sam@email.co.uk"
      fill_in "user[password]", with: 'password'
      fill_in "user[password_confirmation]", with: 'password'

      click_button 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content('Email is invalid')

      fill_in "user[name]", with: "Sammy"
      fill_in "user[email]", with: "sam@email..com"
      fill_in "user[password]", with: 'password'
      fill_in "user[password_confirmation]", with: 'password'

      click_button 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content('Email is invalid')

      fill_in "user[name]", with: "Sammy"
      fill_in "user[email]", with: "sam@emailcom."
      fill_in "user[password]", with: 'password'
      fill_in "user[password_confirmation]", with: 'password'

      click_button 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content('Email is invalid')

      fill_in "user[name]", with: "Sammy"
      fill_in "user[email]", with: "sam@emailcom@"
      fill_in "user[password]", with: 'password'
      fill_in "user[password_confirmation]", with: 'password'

      click_button 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content('Email is invalid')
    end

    it "They fill in form with password and password confirmation that don't match" do
      fill_in "user[name]", with: 'User'
      fill_in "user[email]", with: 'user@email.com'
      fill_in "user[password]", with: 'password'
      fill_in "user[password_confirmation]", with: 'password_password'

      click_button 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end