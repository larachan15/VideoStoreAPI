require "test_helper"

describe Movie do
  # let(:movie) { Movie.new }

  it "must be valid" do
    expect(Movie.first.valid?).must_equal true
  end

  it "must have a title" do
    expect(movies(:one).valid?).must_equal true
    movies(:one).title = ""
    expect(movies(:one).valid?).must_equal false
  end

  it "must have a overview" do
    expect(movies(:one).valid?).must_equal true
    expect(movies(:one).overview).must_equal "cute fish"
    movies(:one).overview = ""
    expect(movies(:one).valid?).must_equal false
  end

  it "must have a release_date" do
    expect(movies(:one).valid?).must_equal true
    expect(movies(:one).release_date).must_be_kind_of Date
    movies(:one).release_date = ""
    expect(movies(:one).valid?).must_equal false
  end

  it "must have an inventory" do
    expect(movies(:one).valid?).must_equal true
    expect(movies(:one).inventory).must_equal 100
    expect(movies(:one).inventory).must_be_kind_of Integer
    movies(:one).inventory = ""
    expect(movies(:one).valid?).must_equal false
  end

  it "inventory cannot be negative number" do
    expect(movies(:one).valid?).must_equal true
    movies(:one).inventory = -1
    expect(movies(:one).valid?).must_equal false
  end
end
