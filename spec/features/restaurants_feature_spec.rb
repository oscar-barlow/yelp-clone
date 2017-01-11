require 'rails_helper'

feature 'Restaurants' do
  context 'no restaurants have been added' do

    scenario 'user cannot add a restaurant if not logged in' do
      visit '/restaurants/new'
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end

    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end

  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content 'No restaurants yet'
    end
  end

  context 'creating restaurants' do

    before do
      visit '/users/sign_up'
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit "/restaurants"
      click_link "Add a restaurant"
      fill_in "restaurant[name]", with: "KFC"
      click_button "Create Restaurant"
      expect(page).to have_content "KFC"
      expect(current_path).to eq "/restaurants"
    end

    scenario 'does not let you submit a name less than 3 characters' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'

      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end

  context 'viewing restaurants' do

    let!(:kfc) { Restaurant.create(name: 'KFC') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content("KFC")
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    before do
      visit '/users/sign_up'
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
      click_link('Add a restaurant')
      fill_in "restaurant[name]", with: "KFC"
      click_button "Create Restaurant"
    end

    scenario "prevent a different user from editing a restaurant" do
      click_link('Sign out')
      visit '/users/sign_up'
      fill_in('Email', with: 'oscar@oscar.com')
      fill_in('Password', with: 'oscar123')
      fill_in('Password confirmation', with: 'oscar123')
      click_button('Sign up')
      click_link("Edit KFC")
      expect(page).to have_content "Cannot edit or delete a restaurant you did not create"
      expect(current_path).to eq "/"
    end

    scenario "let a user edit a restaurant they created" do
      visit('/restaurants')
      click_link("Edit KFC")
      fill_in('Name', with: "Kentucky Fried Chicken")
      fill_in("Description", with: "Deep fried goodness")
      click_button("Update Restaurant")
      expect(page).to have_content "Kentucky Fried Chicken"
      expect(page).to have_content "Deep fried goodness"
      expect(current_path).to eq "/restaurants"
    end

  end

  context 'deleting restaurants' do

    before do
      visit '/users/sign_up'
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
      click_link('Add a restaurant')
      fill_in "restaurant[name]", with: "Burger King"
      click_button "Create Restaurant"
    end

    scenario "removes a restaurant when a user clicks a delete link" do
      visit '/restaurants'
      click_link 'Delete Burger King'
      expect(page).not_to have_content("Burger King")
      expect(page).to have_content("Restaurant deleted successfully")
    end

  end
end
