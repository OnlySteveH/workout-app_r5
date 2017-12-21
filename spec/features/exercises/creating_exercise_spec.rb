require 'rails_helper'

RSpec.feature "Creating an exercise" do
  before do
    @steve = User.create!(first_name: "Steve", last_name: "Hunter", email: "steve@example.com", password: "password")
    login_as @steve
    visit root_path
    click_link "My Lounge"
    click_link "New Workout"
    expect(page).to have_link "Back"
  end
  
  scenario "with valid inputs creates an exercise" do

    
    fill_in "Duration", with: 70
    fill_in "Workout details", with: "Weight lifting"
    fill_in "Activity date", with: 3.days.ago
    click_button "Create Exercise"
    
    expect(page).to have_content "Exercise has been created"
    exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(@steve, exercise))
    expect(exercise.user_id).to eq @steve.id
  end
  
  scenario "with invalid inputs does not create an exercise" do

    fill_in "Duration", with: ""
    fill_in "Workout details", with: ""
    fill_in "Activity date", with: ""
    click_button "Create Exercise"
    
    expect(page).to have_content("Exercise has not been created")
    expect(page).not_to have_content("Exercise has been created")
    expect(page).to have_content("Workout date can't be blank")
    expect(page).to have_content("Workout can't be blank")
    expect(page).to have_content("Duration in min is not a number")
  end
  
  scenario "with a future date does not create an exercise" do
    
    fill_in "Duration", with: 70
    fill_in "Workout details", with: "Weight lifting"
    fill_in "Activity date", with: Date.today + 2.days
    click_button "Create Exercise"
    
    expect(page).to have_content("cannot be in the future")
    expect(page).to have_content "Exercise has not been created"
  end
  
  scenario "with a date older than a week does not create an exercise" do
    
    fill_in "Duration", with: 70
    fill_in "Workout details", with: "Weight lifting"
    fill_in "Activity date", with: Date.today - 8.days
    click_button "Create Exercise"
    
    expect(page).to have_content("cannot be older than a week")
    expect(page).to have_content "Exercise has not been created"    
  end
  
end