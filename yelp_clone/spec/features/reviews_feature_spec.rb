require 'rails_helper'

feature 'reviewing' do
  before do
    sign_up
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    fill_in 'Description', with: 'Deep fried goodness'
    click_button 'Create Restaurant'
  end

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'users can only leave one review per restaurant' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "Gets better with age"
    select '5', from: 'Rating'
    expect{click_button 'Leave Review'}.to_not change{Review.count}
  end

end
