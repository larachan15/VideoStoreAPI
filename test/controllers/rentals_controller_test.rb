require "test_helper"

describe RentalsController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  describe "checkin" do
    it "correctly updates available inventory" do
      post checkout_path, params: { customer_id: customers(:dionisia).id, movie_id: movies(:up).id }
      movies(:up).reload
      customers(:dionisia).reload
      # binding.pry
      expect(movies(:up).available_inventory).must_equal 199
      expect(customers(:dionisia).movies_checked_out_count).must_equal 1

      post checkin_path, params: { customer_id: customers(:dionisia).id, movie_id: movies(:up).id }
      movies(:up).reload
      customers(:dionisia).reload
      expect(movies(:up).available_inventory).must_equal 200
      expect(customers(:dionisia).movies_checked_out_count).must_equal 0
    end

    it "doesn't increase available_inventory more than what is actually available" do
      rental = rentals(:two)
      customer = rental.customer
      movie = rental.movie

      post checkin_path, params: { customer_id: customers(:dionisia).id, movie_id: movies(:up).id }
      movies(:up).reload
      expect(movies(:up).available_inventory).must_equal 200
    end

    it "won't update available inventory if invalid" do
      post checkin_path, params: { customer_id: nil, movie_id: movies(:up).id }
      movies(:up).reload
      expect(movies(:up).available_inventory).must_equal 200
      must_respond_with :bad_request
    end
  end

  describe "checkout" do
    it "successfully creates a new rental" do
      post checkout_path, params: { customer_id: customers(:dionisia).id, movie_id: movies(:up).id }
      movies(:up).reload
      customers(:dionisia).reload
      # binding.pry
      expect(movies(:up).available_inventory).must_equal 199
      expect(customers(:dionisia).movies_checked_out_count).must_equal 1
    end

    it "won't create a rental if invalid" do
      post checkout_path, params: { customer_id: nil, movie_id: movies(:up).id }
      movies(:up).reload
      expect(movies(:up).available_inventory).must_equal 200
      must_respond_with :bad_request
    end
  end
end
