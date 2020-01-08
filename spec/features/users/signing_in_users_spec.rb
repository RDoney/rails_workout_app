require 'rails_helper'

RSpec.feature "User attempts to sign in" do
  before do
    @john = User.create!(email: "john@example.com", password: "password", first_name: "John", last_name: "Doe")
  end

  scenario "with valid credentials" do
    visit '/'
    click_link "Sign in"
    fill_in 'Email', with: @john.email
    fill_in 'Password', with: @john.password
    click_button "Log in"

    flash_message = "Signed in successfully."
    expect(page).to have_content(flash_message)
    expect(page).to have_content("Signed in as #{@john.email}")
    expect(page).not_to have_content("Sign in")
    expect(page).not_to have_content("Sign up")

  end

end