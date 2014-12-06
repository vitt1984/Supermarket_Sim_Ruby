require 'test/unit'
require_relative 'cashier'
require_relative 'customer'
require_relative 'product'
require_relative 'price'
require_relative 'purchase'

class CashierTest < Test::Unit::TestCase

  def setup
    valid_border_start = Date.parse('2000-12-01')
    valid_border_end = Date.parse('2999-12-10')

    @product_a = Product.new('A', Price.new(7))
    @product_b = Product.new('B', Price.new(5,1,true,true))
    @product_c = Product.new('C', Price.new(3))
    @product_b.price.special_offer = Offer.new(valid_border_start, valid_border_end, 3, 2)

    @available_products = Hash.new
    @available_products[@product_a.name] = @product_a
    @available_products[@product_b.name] = @product_b
    @available_products[@product_c.name] = @product_c

  end

  # Testing merge of a customer's items
  def test_merge
    customer = Customer.new('Customer')
    customer.add_to_cart(Purchase.new(@product_b.name,5))
    customer.add_to_cart(Purchase.new(@product_c.name,10))
    customer.add_to_cart(Purchase.new(@product_c.name,2))
    customer.add_to_cart(Purchase.new(@product_a.name,10))
    customer.add_to_cart(Purchase.new(@product_b.name,3))

    cashier = Cashier.new(@available_products)
    items_hash = cashier.merge_items(customer.items)

    assert_equal(items_hash[@product_a.name].quantity, 10)
    assert_equal(items_hash[@product_b.name].quantity, 8)
    assert_equal(items_hash[@product_c.name].quantity, 12)
  end

  # Testing customer handling
  def test_purchase
    customer1 = Customer.new('C1')
    purchase = Purchase.new(@product_a.name, 4)
    customer1.add_to_cart(purchase)
    cashier = Cashier.new(@available_products)
    assert_equal(cashier.handle_customer(customer1),28)
  end

  # Testing customer handling with an offer
  def test_purchase_offer
    customer1 = Customer.new('C1')
    purchase = Purchase.new(@product_b.name, 14)
    customer1.add_to_cart(purchase)
    cashier = Cashier.new(@available_products)
    assert_equal(cashier.handle_customer(customer1),5*2*4+5*2)
  end
end