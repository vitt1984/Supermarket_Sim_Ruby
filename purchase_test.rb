require 'test/unit'
require_relative 'product'
require_relative 'price'
require_relative 'purchase'
require_relative 'offer'

class PurchaseTest < Test::Unit::TestCase

  attr_reader :productA, :productB
  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    aValidBorderStart = Date.parse('2000-12-01')
    aValidBorderEnd = Date.parse('2999-12-10')

    @productA = Product.new("A", Price.new(7))
    @productB = Product.new("B", Price.new(5,1,true,true))
    @productB.price.specialOffer = Offer.new(aValidBorderStart, aValidBorderEnd, 3, 2)
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_purchase_price_calculation
    purchase = Purchase.new(@productA, 4)
    assert_equal(purchase.get_purchase_price,28)
  end

  def test_purchase_price_calculation_with_offer
    purchase = Purchase.new(@productB, 14)
    assert_equal(purchase.get_purchase_price,5*2*4+5*2)
  end
end