require 'rails_helper'

RSpec.feature "On visiting the signup page" do
  scenario "the user can enter their information" do
    visit "/"
    click_link "Sign up"
    fill_in "First name", with: "Steve"
    fill_in "Last name", with: "Hunter"
    fill_in "Email", with: "steve@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    expect(page).to have_content "You have signed up successfully"
    visit "/"
    expect(page).to have_content("Steve Hunter")
  end
end