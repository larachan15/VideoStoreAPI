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

  # it "must have a unique name" do
  #   :TODO
  # end

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

  it "must have a phone number" do
    expect(customers(:one).valid?).must_equal true
    expect(customers(:one).phone).must_equal "123-123-1234"
    customers(:one).phone = ""
    expect(customers(:one).valid?).must_equal false
  end
end
