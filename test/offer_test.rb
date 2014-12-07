require 'test/unit'
require_relative '../lib/offer'
require 'Date'

class OfferTest < Test::Unit::TestCase

  def setup
    AuditSingleton.instance.enable_stdout=false
    @base_price = 1
    @offer = Offer.new(Date.parse('2014-12-01'),Date.parse('2014-12-10'),3,2)
  end

  # Testing offer validity
  def test_validity
    valid_date = Date.parse('2014-12-05')
    valid_border_start = Date.parse('2014-12-01')
    valid_border_end = Date.parse('2014-12-10')
    invalid_before = Date.parse('2014-11-05')
    invalid_after = Date.parse('2014-12-15')

    assert_equal(@offer.is_valid(valid_date),true)
    assert_equal(@offer.is_valid(valid_border_start),true)
    assert_equal(@offer.is_valid(valid_border_end),true)
    assert_equal(@offer.is_valid(invalid_before),false)
    assert_equal(@offer.is_valid(invalid_after),false)
  end

  # Testing offer price calculation
  def test_price_calculation
    price_with_same_items = @offer.calculate_price(10,@base_price,'€')
    assert_equal(price_with_same_items, (@base_price*2*3) + @base_price)

    price_with_more_items = @offer.calculate_price(9,@base_price,'€')
    assert_equal(price_with_more_items, (@base_price*2*3))
  end
end