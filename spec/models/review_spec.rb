require 'rails_helper'

RSpec.describe Review, type: :model do

  it "is invalid if the rating is more than 5" do
    review = Review.create(rating: 10)
    expect(review).to have(1).errors
  end
end
