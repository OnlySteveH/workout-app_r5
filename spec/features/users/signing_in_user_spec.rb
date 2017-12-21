require 'rails_helper'

RSpec.feature "On visiting the sign-in page" do
    
  before "create a user" do
    @steve = User.create!(first_name: "John", last_name: "Doe", email: "steve@example.com", password: "password")
  end
  
  scenario "the user can enter valid credentials to sign in" do  
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: @steve.email
    fill_in "Password", with: @steve.password
    click_button "Log in"
    expect(page).to have_content "Signed in successfully"
    expect(page).to have_content "Signed in as #{@steve.full_name}"
    #expect(page).to have_link(destroy_user_session_path, method: :delete)
    expect(page).to have_link "Sign out"
    expect(page).not_to have_link("Sign in")
    expect(page).not_to have_link("Sign up")
  end
  
end