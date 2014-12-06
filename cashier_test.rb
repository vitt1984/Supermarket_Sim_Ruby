require 'test/unit'
require_relative 'cashier'
require_relative 'customer'
require_relative 'product'
require_relative 'price'
require_relative 'purchase'

class CashierTest < Test::Unit::TestCase

  attr_reader :productA, :productB, :productC
  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @productA = Product.new("A", Price.new(1))
    @productB = Product.new("B", Price.new(1))
    @productC = Product.new("C", Price.new(1))
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_merge
    customer = Customer.new("Customer")
    customer.add_to_cart(Purchase.new(@productB,5))
    customer.add_to_cart(Purchase.new(@productC,10))
    customer.add_to_cart(Purchase.new(@productC,2))
    customer.add_to_cart(Purchase.new(@productA,10))
    customer.add_to_cart(Purchase.new(@productB,3))

    items_hash = Cashier.merge_items(customer.items)
    assert_equal(items_hash[@productA.name].quantity, 10)
    assert_equal(items_hash[@productB.name].quantity, 8)
    assert_equal(items_hash[@productC.name].quantity, 12)
  end
end