require 'rails_helper'

RSpec.feature "When signing out a signed in user" do
  before do
    @john = User.create!(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")
    login_as @john
  end
  
  scenario "the user can click the sign out button and be redirected to the home page" do
    visit "/"
    click_link "Sign out"
    expect(page).to have_content("Signed out successfully")
    expect(current_path).to eq root_path
    expect(page).not_to have_link("Sign out")
    expect(page).not_to have_content("#{@john.email}")
    expect(page).to have_link("Sign in")
    expect(page).to have_link("Sign up")
  end
  
end