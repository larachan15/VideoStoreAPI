require "test_helper"

describe Movie do
  # let(:movie) { Movie.new }

  it "must be valid" do
    expect(Movie.first.valid?).must_equal true
  end
end
