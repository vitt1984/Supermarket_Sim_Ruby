require 'test/unit'
require_relative 'product'
require_relative 'price'
require_relative 'purchase'
require_relative 'offer'

class PurchaseTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    valid_border_start = Date.parse('2000-12-01')
    valid_border_end = Date.parse('2999-12-10')

    @product_a = Product.new('A', Price.new(7))
    @product_b = Product.new('B', Price.new(5,1,true,true))
    @product_b.price.special_offer = Offer.new(valid_border_start, valid_border_end, 3, 2)
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_purchase
    purchase = Purchase.new(@product_a, 4)
    assert_equal(purchase.get_purchase_price,28)
  end

  def test_purchase_offer
    purchase = Purchase.new(@product_b, 14)
    assert_equal(purchase.get_purchase_price,5*2*4+5*2)
  end
end