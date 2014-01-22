require 'minitest/spec'
require 'minitest/autorun'
require 'leapFrogAPI/customer'

describe Customer do
  describe "initialize" do
    it "should have accessors for income, zipcode, and age" do
      c = Customer.new(100, 60606, 29)
      assert_equal(c.income, 100)
      assert_equal(c.zipcode, 60606)
      assert_equal(c.age, 29)
    end
  end
end
