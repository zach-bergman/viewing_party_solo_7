require "rails_helper"

RSpec.describe "Admin Dashboard" do
  describe "Admin Dashboard" do
    it "can see all default users email addresses" do
      admin = User.create!(name: "Admin", email: "admin@email.com", password: "password", 
      password_confirmation: "password", role: 2)

      user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "password",
      password_confirmation: "password")
      user_2 = User.create!(name: 'Billy', email: 'billy@email.com', password: "password",
      password_confirmation: "password")
      manager = User.create!(name: 'Linda', email: 'linda@email.com', password: "password",
      password_confirmation: "password", role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_index_path

      within "#default_users" do
        expect(page).to have_link(user.email)
        expect(page).to have_link(user_2.email)
        expect(page).to_not have_link(admin.email)
        expect(page).to_not have_link(manager.email)
      end
    end

    it "can click on a default user's email address and be taken to the admin user dashboard" do
      admin = User.create!(name: "Admin", email: "admin@email.com", password: "password", 
      password_confirmation: "password", role: 2)

      user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "password",
      password_confirmation: "password")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_index_path

      click_link user.email

      expect(current_path).to eq(admin_user_path(user))
    end

    it "won't allow default users or visitors to access the admin dashboard" do
      visit root_path
      visit admin_dashboard_index_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You're not authorized to access this page.")

      user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "password",
      password_confirmation: "password")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_dashboard_index_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You're not authorized to access this page.")
    end
  end
end

# As a visitor or default user 
# If I try to go to any admin routes ('/admin/dashboard' or '/admin/users/:id')
# I get redirected to the landing page
# And I see a message pop up telling me I'm not authorized to access those pages. 