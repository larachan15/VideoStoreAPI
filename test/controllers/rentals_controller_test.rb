require "test_helper"

describe RentalsController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  describe "checkin" do
    it "correctly updates available inventory" do
      rental = rentals(:one)
      customer = rental.customer
      movie = rental.movie

      expect {
        post checkin_path, params: { customer_id: rental.customer_id, movie_id: rental.movie_id }
      }.must_change "Movie.available_inventory", 2

    end

    it "won't update available inventory if invalid" do


    end
  end

  describe "checkout" do

    before do
      @params = {customer_id: customers(:dionisia).id, movie_id: movies(:up).id}
    end

    it "successfully creates a new rental" do

      customer = rental.customer
      movie = rental.movie
      rental = Rental.new(customer_id: customer, movie_id: movie, due_date: due_date, checkout_date: checkout_date)

      expect {
        post checkin_path, params: @params
      }.must_change "Rental.count", 3

    end

    it "won't create a rental if invalid" do


    end

  end
end
