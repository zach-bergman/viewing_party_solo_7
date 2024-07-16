require "rails_helper"

RSpec.describe "User Log In/Log Out" do
  it "the user can log in" do
    user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "password",
    password_confirmation: "password")

    visit root_path

    click_link "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation

    click_button "Log In"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Welcome, Tommy!")
  end

  it "the user cannot log in with incorrect credentials - email" do
    user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "password",
    password_confirmation: "password")

    visit login_path

    fill_in :email, with: "wrong_email"
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation

    click_button "Log In"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Invalid Credentials")
  end

  it "the user cannot log in with incorrect credentials - password" do
    user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "password",
    password_confirmation: "password")

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: "wrong_password"
    fill_in :password_confirmation, with: user.password_confirmation

    click_button "Log In"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Invalid Credentials")
  end

  it "has a text field to enter a location, location is shown on user page" do
    user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "password",
    password_confirmation: "password")

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    fill_in :location, with: "Denver, CO"

    click_button "Log In"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Location: Denver, CO")
  end

  it "the user can log out" do
    user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "password",
    password_confirmation: "password")

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    fill_in :location, with: "Denver, CO"

    click_button "Log In"

    expect(current_path).to eq(user_path(user))

    expect(page).to have_button("Log Out")

    click_button "Log Out"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Successfully Logged Out")
  end

  it "once logged out, the location last entered when logging in is populated 
  in the location field" do
    user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "password",
    password_confirmation: "password")

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    fill_in :location, with: "Denver, CO"

    click_button "Log In"

    click_button "Log Out"

    expect(current_path).to eq(root_path)

    visit login_path

    expect(page).to have_field(:location, with: "Denver, CO")
  end

  it "user is still logged in after visiting another website" do
    user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "password",
    password_confirmation: "password")

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    fill_in :location, with: "Denver, CO"

    click_button "Log In"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Tommy's Dashboard")
    expect(page).to have_content("Location: Denver, CO")
    expect(page).to have_button("Log Out")

    visit "https://www.google.com"

    visit user_path(user)

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Tommy's Dashboard")
    expect(page).to have_content("Location: Denver, CO")
    expect(page).to have_button("Log Out")
  end

  it "shows correct log in/log out links if user is logged in or not" do
    user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "password",
    password_confirmation: "password")

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    fill_in :location, with: "Denver, CO"

    click_button "Log In"

    visit root_path

    expect(page).to_not have_link("Log In")
    expect(page).to_not have_button("Create New User")
    expect(page).to have_button("Log Out")

    click_button "Log Out"

    expect(current_path).to eq(root_path)

    expect(page).to have_link("Log In")
    expect(page).to have_button("Create New User")
  end

  describe "Admin User Log In" do
    it "the admin user can log in and is taken to admin dashboard" do
      admin = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "password",
      password_confirmation: "password", role: 2)

      visit login_path

      fill_in :email, with: admin.email
      fill_in :password, with: admin.password
      fill_in :password_confirmation, with: admin.password_confirmation
      fill_in :location, with: "Denver, CO"

      click_button "Log In"

      expect(current_path).to eq(admin_dashboard_index_path)
    end
  end
end