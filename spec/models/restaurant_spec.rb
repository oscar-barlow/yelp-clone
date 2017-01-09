require 'rails_helper'

RSpec.describe Restaurant, type: :model do

  it "is not valid with a name of less than three characters" do
    restaurant = Restaurant.create(name: "kf")
    expect(restaurant).to have(1).errors
  end

end
