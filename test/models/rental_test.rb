require "test_helper"

describe Rental do
  # let(:rental) { Rental.new }

  it "must be valid" do
    expect(Rental.first.valid?).must_equal false
  end
end
