require "test_helper"
require 'date'

describe CustomersController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  CUSTOMER_FIELDS = %w(id name registered_at address city state postal_code phone).sort
  # Helper method!
  def parse_json(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do
    it "is a working route" do
      get customers_path

      body = parse_json(expected_type: Array)
      expect(body.length).must_equal Customer.count
    end

    it "returns and empty array when there are no customers" do
      Customer.destroy_all
      get customers_path
      body = parse_json(expected_type: Array)
      expect(body.length).must_equal 0
    end
  end

  describe "show" do
    it "returns a customer with exactly the required fields" do
      customer = Customer.first

      get customer_path(customer)
      # binding.pry
      body = parse_json(expected_type: Hash)
      expect(body.keys.sort).must_equal CUSTOMER_FIELDS
    end

    it "doesn't blow up when a customer DNE" do
      customer = Customer.first
      customer.destroy

      get customer_path(customer)

      body = parse_json(expected_type: Hash, expected_status: :not_found)
      expect(body).must_include "errors"
    end
  end

  describe "create" do
    before do
      date = DateTime.now
      @customer = {
        name: "Ada",
        registered_at: date,
        address: "123 River Road",
        city: "Seattle",
        state: "WA",
        postal_code: "98155",
        phone: "206-421-9876"
      }
    end

    it "creates a new customer given valid data" do
      expect{
        post customers_path, params: { customer: @customer } }.must_change "Customer.count", 1
      must_respond_with :success

      body = parse_json(expected_type: Hash)
      expect(body).must_include "id"
    end

    it "returns an error for invalid data" do
      @customer = {
        name: nil
      }

      expect{
        post customers_path, params: { customer: @customer } }.wont_change "Customer.count"
        # binding.pry
        body = JSON.parse(response.body)
        expect(body).must_be_kind_of Hash
        expect(body).must_include "errors"
        expect(body["errors"]).must_include "name"
        must_respond_with :bad_request
      end
  end
end
