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

  describe 'relations' do
    it 'has rentals' do
      rental = rentals(:one)
      movie = movies(:nemo)

      movie = Movie.find_by(id: rental.movie_id )
      expect(movie.rentals.first.id).must_equal rental.id
    end
  end

  describe "movie model methods" do
    it "checks movie is available" do
      expect(Movie.first.is_available?).must_equal true
      invalid_movie = Movie.first
      invalid_movie.available_inventory = 0
      expect(invalid_movie.is_available?).must_equal false
    end

    it "decrement inventory" do
      movie = Movie.first
      expect(movie.available_inventory).must_equal 200
      movie.decrement_inventory!
      movie.reload
      expect(movie.available_inventory).must_equal 199
    end

    it "increment inventory" do
      movie = Movie.first
      movie.decrement_inventory!
      movie.reload
      expect(movie.available_inventory).must_equal 199
      movie.increment_inventory!
      movie.reload
      expect(movie.available_inventory).must_equal 200
    end
  end
end
