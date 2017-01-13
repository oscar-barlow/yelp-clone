def sign_up
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'abcd1234')
  fill_in('Password confirmation', with: 'abcd1234')
  click_button('Sign up')
end

def sign_in
  visit('/')
  click_link('Sign in')
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'abcd1234')
  click_button('Log in')
end

def create_restaurant
 visit '/restaurants'
 click_link 'Add a restaurant'
 fill_in 'Name', with: 'KFC'
 fill_in 'Description', with: 'Deep fried goodness'
 click_button 'Create Restaurant'
end
