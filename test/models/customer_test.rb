require "test_helper"

describe Customer do
  # let(:customer) { Customer.new }

  it "must be valid" do
    expect(Customer.first.valid?).must_equal true
  end

  it "must have a name" do
    expect(customers(:one).valid?).must_equal true
    customers(:one).name = ""
    expect(customers(:one).valid?).must_equal false
  end

  it "must have an address" do
    expect(customers(:one).valid?).must_equal true
    expect(customers(:one).address).must_equal "address 1"
    customers(:one).address = ""
    expect(customers(:one).valid?).must_equal false
  end

  it "must have a city" do
    expect(customers(:one).valid?).must_equal true
    expect(customers(:one).city).must_equal "d city"
    customers(:one).city = ""
    expect(customers(:one).valid?).must_equal false
  end

  it "must have a state" do
    expect(customers(:one).valid?).must_equal true
    expect(customers(:one).state).must_equal "d state"
    customers(:one).state = ""
    expect(customers(:one).valid?).must_equal false
  end

  it "must have a postal code" do
    expect(customers(:one).valid?).must_equal true
    expect(customers(:one).postal_code).must_equal "23454"
    customers(:one).postal_code = ""
    expect(customers(:one).valid?).must_equal false
  end

  it "does not accept postal code that is not 5 digits as string" do
    customers(:one).postal_code = "123"
    expect(customers(:one).valid?).must_equal false
    customers(:one).postal_code = "123456"
    expect(customers(:one).valid?).must_equal false
    customers(:one).postal_code = "12345"
    expect(customers(:one).valid?).must_equal true
  end

  it "must have a phone number" do
    expect(customers(:one).valid?).must_equal true
    expect(customers(:one).phone).must_equal "123-123-1234"
    customers(:one).phone = ""
    expect(customers(:one).valid?).must_equal false
  end

  it "does not accept phone number that has incorrect format" do
    customers(:one).postal_code = "1"
    expect(customers(:one).valid?).must_equal false
    customers(:one).postal_code = "1-1-1"
    expect(customers(:one).valid?).must_equal false
    customers(:one).postal_code = "123-456-789"
    expect(customers(:one).valid?).must_equal false
    customers(:one).postal_code = "123-456-7890"
    expect(customers(:one).valid?).must_equal true
  end

  it "has movies_checked_out_count" do
    expect(customers(:one).valid?).must_equal true
    expect(customers(:one).movies_checked_out_count).must_equal 0
    customers(:one).movies_checked_out_count = nil
    expect(customers(:one).valid?).must_equal false
  end
end
