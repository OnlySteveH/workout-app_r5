require "rails_helper"

RSpec.feature "Editing Exercises" do
  before do
    @owner = User.create(email: "john@example.com", password: "password")

    login_as(@owner)
    
    @owner_exercise = @owner.exercises.create(duration_in_min: 20,
                                              workout: "My body building activity",
                                              workout_date: Date.today)
                                              
    visit root_path
    click_link "My Lounge"
    
    @path = "/users/#{@owner.id}/exercises/#{@owner_exercise.id}/edit"
    @link = "a[href=\'#{@path}']"
    find(@link).click
  end
  
  scenario "with valid data succeeds" do

    fill_in "Duration", with: 45
    click_button "Update Exercise"
    
    expect(page).to have_content("Exercise has been updated")
    expect(page).to have_content(45)
    expect(page).not_to have_content(20)
    
  end
  
  scenario "with invalid data fails" do
    
    fill_in "Duration", with: 0
    fill_in "Workout details", with: ""
    click_button "Update Exercise"
    
    expect(page).not_to have_content("Exercise has been updated")
    expect(page).to have_content("Exercise has not been updated")

  end
  
end
  