require 'rails_helper'

RSpec.feature "On visiting the signup page" do
  def setup
    visit "/"
    click_link "Sign up"
    fill_in "First name", with: "Steve"
    fill_in "Last name", with: "Hunter"
    fill_in "Email", with: "steve@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"    
  end
  
  scenario "entering valid information signs the user up" do

    setup
    expect(page).to have_content "You have signed up successfully"
    
    visit "/"
    expect(page).to have_content("Steve Hunter")
    
  end
  
  scenario "on signing up with valid cedentials a chatroom is created" do
    setup
    user = User.last
    room = user.room
    room_name = user.full_name.split.join('-')
    expect(room.name). to eq(room_name)    
  end
  
  scenario "entering blank first and last names fails to sign the user up" do
    visit "/"
    click_link "Sign up"
    fill_in "First name", with: ""
    fill_in "Last name", with: ""
    fill_in "Email", with: "steve@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    expect(page).to have_content "First name can't be blank"
    expect(page).to have_content "Last name can't be blank"
  end
  
end