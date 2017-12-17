require 'rails_helper'

RSpec.feature "On visiting the home page" do
  scenario "the user will see certain content" do
    visit "/"
    expect(page).to have_link("Home")
    expect(page).to have_link("Athletes Den")
    expect(page).to have_content("Workout Lounge!")
    expect(page).to have_content("Show off your workout")
  end
end