require 'rails_helper'

RSpec.feature "Unfollowing Friend" do
  before do
    @john = User.create(email: "john@example.com", password: "password", first_name: "John", last_name: "Doe")
    @sarah = User.create(email: "sarah@example.com", password: "password", first_name: "Sarah", last_name: "Anderson")

    @e1 = @john.exercises.create(duration_in_min: 20, workout: "Bodybuilding activity", workout_date: Date.today)
    @e2 = @sarah.exercises.create(duration_in_min: 55, workout: "Weight lifting", workout_date: 2.days.ago)

    login_as(@john)
    @following = Friendship.create(user: @john, friend: @sarah)
  end

  scenario do
    visit '/'

    click_link "My Lounge"
    link = "a[href='/friendships/#{@following.id}'][data-method='delete']"
    find(link).click

    expect(page).to have_content(@sarah.full_name + " unfollowed")
  end
end