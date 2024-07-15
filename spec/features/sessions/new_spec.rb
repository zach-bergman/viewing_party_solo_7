require "rails_helper"

RSpec.describe "User Log In" do
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
end