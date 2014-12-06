require 'test/unit'
require_relative 'offer'
require 'Date'

class OfferTest < Test::Unit::TestCase

  attr_reader :basePrice
  attr_reader :offer

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @basePrice = 1
    @offer = Offer.new(Date.parse('2014-12-01'),Date.parse('2014-12-10'),3,2)
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end


  def test_validity
    aValidDate = Date.parse('2014-12-05')
    aValidBorderStart = Date.parse('2014-12-01')
    aValidBorderEnd = Date.parse('2014-12-10')
    aInvalidBefore = Date.parse('2014-11-05')
    aInvalidAfter = Date.parse('2014-12-15')

    assert_equal(@offer.isValid(aValidDate),true)
    assert_equal(@offer.isValid(aValidBorderStart),true)
    assert_equal(@offer.isValid(aValidBorderEnd),true)
    assert_equal(@offer.isValid(aInvalidBefore),false)
    assert_equal(@offer.isValid(aInvalidAfter),false)
  end

  def test_price_calculation
    priceWithSameItemsThanThreshold = @offer.calculatePrice(10,@basePrice)
    assert_equal(priceWithSameItemsThanThreshold, (@basePrice*2*3) + @basePrice)

    priceWithMoreItemsThanThreshold = @offer.calculatePrice(9,@basePrice)
    assert_equal(priceWithMoreItemsThanThreshold, (@basePrice*2*3))
  end
end