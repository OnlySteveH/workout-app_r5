require 'rails_helper'

RSpec.feature "On creating an exercise" do
  before do
    @steve = User.create!(first_name: "Steve", last_name: "Hunter", email: "steve@example.com", password: "password")
    login_as @steve 
  end
  
  scenario "with valid inputs creates an exercise" do
    visit root_path
    click_link "My Lounge"
    click_link "New workout"
    expect(page).to have_link "Back"
    
    fill_in "Duration", with: ""
    fill_in "Workout details", with: ""
    fill_in "Activity date", with: ""
    click_button "Create Exercise"
    
    expect(page).to have_content("Exercise has not been created")
    expect(page).not_to have_content("Exercise has been created")
    expect(page).to have_content("Activity date can't be blank")
    expect(page).to have_content("Workout details can't be blank")
    expect(page).to have_content("Duration in min is not a number")
  
  end
end