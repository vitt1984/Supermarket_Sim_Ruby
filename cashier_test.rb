require 'test/unit'
require_relative 'cashier'
require_relative 'customer'
require_relative 'product'
require_relative 'price'
require_relative 'purchase'

class CashierTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @product_a = Product.new('A', Price.new(1))
    @product_b = Product.new('B', Price.new(1))
    @product_c = Product.new('C', Price.new(1))
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_merge
    customer = Customer.new('Customer')
    customer.add_to_cart(Purchase.new(@product_b,5))
    customer.add_to_cart(Purchase.new(@product_c,10))
    customer.add_to_cart(Purchase.new(@product_c,2))
    customer.add_to_cart(Purchase.new(@product_a,10))
    customer.add_to_cart(Purchase.new(@product_b,3))

    items_hash = Cashier.merge_items(customer.items)
    assert_equal(items_hash[@product_a.name].quantity, 10)
    assert_equal(items_hash[@product_b.name].quantity, 8)
    assert_equal(items_hash[@product_c.name].quantity, 12)
  end
end