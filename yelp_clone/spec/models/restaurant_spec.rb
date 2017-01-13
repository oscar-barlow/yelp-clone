require 'rails_helper'


describe Restaurant, type: :model do


it 'is not valid with a name of less than three characters' do
  restaurant = Restaurant.new(name: "kf")
  expect(restaurant).to have(1).error_on(:name)
  expect(restaurant).not_to be_valid
  end

  it "is not valid unless it has a unique name" do
    user = User.create(email: "test@test.com", password: "test123")
    Restaurant.create(name: "Moe's Tavern", user_id: user.id)
    restaurant = Restaurant.create(name: "Moe's Tavern", user_id: user.id)
    p restaurant.errors
    expect(restaurant).to have(1).error_on(:name)
  end

    it {is_expected.to belong_to :user}
    it {is_expected.to have_many :reviews}

end
