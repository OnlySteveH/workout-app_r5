require "rails_helper"

RSpec.feature "Deleting an exercise" do
  before do
    @owner = User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")

    login_as(@owner)
    
    @owner_exercise = @owner.exercises.create(duration_in_min: 41,
                                              workout: "My body building activity",
                                              workout_date: Date.today)
                                              
    visit root_path
    click_link "My Lounge"
    
    @path = "/users/#{@owner.id}/exercises/#{@owner_exercise.id}"
    @link = "//a[contains(@href,\'#{@path}\') and .//text()='Destroy']"
    find(:xpath, @link).click
  end
  
  scenario "produces a flash confirmation message" do
    expect(page).to have_content("Exercise has been deleted")
  end
end