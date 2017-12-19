require 'rails_helper'

RSpec.feature "On creating an exercise" do
  before do
    @steve = User.create!(email: "steve@example.com", password: "password")
    login_as @steve 
  end
  
  scenario "with valid inputs creates an exercise" do
    visit root_path
    click_link "My Lounge"
    click_link "New workout"
    expect(page).to have_link "Back"
    
    fill_in "Duration", with: 70
    fill_in "Workout details", with: "Weight lifting"
    fill_in "Activity date", with: "2017-01-27"
    click_button "Create Exercise"
    
    expect(page).to have_content "Exercise has been created"
    exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(@steve, exercise))
    expect(exercise.User_id).to eq @steve.id
  end
end