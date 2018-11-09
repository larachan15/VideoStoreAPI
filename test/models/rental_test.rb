require "test_helper"

describe Rental do

  it "must have a checkout_date" do
    expect(rentals(:one).valid?).must_equal true
    rentals(:one).checkout_date = ""
    expect(rentals(:one).valid?).must_equal false
  end

  it "gets the first rental that was checked out" do
    rental = Rental.get_rental(rentals(:one).customer_id, rentals(:one).movie_id)
    expect(rental).must_be_instance_of Rental
    expect(rental.movie.title).must_equal "Nemo"
  end

  describe 'relations' do
    it 'belongs to customer' do
      rental = rentals(:one)
      customer = customers(:karis)

      customer_rental = Customer.find_by(id: rental.customer_id )
      expect(customer_rental.rentals.first.id).must_equal rental.id
    end

    it 'belongs to movie' do
      rental = rentals(:one)
      movie = movies(:nemo)

      movie_rental = Movie.find_by(id: rental.movie_id )
      expect(movie_rental.rentals.first.id).must_equal rental.id
    end
  end
end
