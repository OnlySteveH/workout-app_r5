require "rails_helper"

RSpec.feature "Listing Exercises" do
  before do
    @john = User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")
    @dave = User.create(first_name: "Dave", last_name: "Dee", email: "dave@example.com", password: "password")
    login_as(@john)
    
    @e1 = @john.exercises.create( duration_in_min: 20,
                                  workout: "My body building activity",
                                  workout_date: Date.today)

    @e2 = @john.exercises.create( duration_in_min: 55,
                                  workout: "Weight lifting",
                                  workout_date: 3.days.ago)
                                  
    @following = Friendship.create(user: @john, friend: @dave)

    @e3 = @john.exercises.create( duration_in_min: 32,
                                  workout: "Kickboxing",
                                  workout_date: 8.days.ago)
  end
  
  scenario "shows user's workouts" do
    visit '/'
    
    click_link "My Lounge"
    
    expect(page).to have_content(@e1.duration_in_min)
    expect(page).to have_content(@e1.workout)
    expect(page).to have_content(@e1.workout_date)
    
    expect(page).to have_content(@e2.duration_in_min)
    expect(page).to have_content(@e2.workout)
    expect(page).to have_content(@e2.workout_date)
    
    expect(page).not_to have_content(@e3.duration_in_min)
    expect(page).not_to have_content(@e3.workout)
    expect(page).not_to have_content(@e3.workout_date)
  
  end
  
  scenario "shows no exercises if none created" do
    @john.exercises.delete_all
    visit root_path
    click_link "My Lounge"
    expect(page).to have_content("No Workouts Yet")
  end
  
  scenario "logging in as alternative user has the same impact" do
    login_as @dave
    visit root_path
    click_link "My Lounge"
    expect(page).to have_content("No Workouts Yet")
  end
  
  scenario "shows a list of users if they are friends" do
    visit root_path
    click_link "My Lounge"
    expect(page).to have_content("My Friends")
    expect(page).to have_link @dave.full_name
    expect(page).to have_link "Unfollow"
  end
  
end