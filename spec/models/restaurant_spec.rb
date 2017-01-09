require 'rails_helper'

RSpec.describe Restaurant, type: :model do

  it "is not valid with a name of less than three characters" do
    restaurant = Restaurant.create(name: "kf")
    expect(restaurant).to have(1).errors
  end

  it "is not valid unless it has a unique name" do
    Restaurant.create(name: "Moe's Tavern")
    restaurant = Restaurant.create(name: "Moe's Tavern")
    expect(restaurant).to have(1).errors
  end

end
