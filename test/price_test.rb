require 'test/unit'
require_relative '../lib/price'
require_relative '../lib/offer'

class PriceTest < Test::Unit::TestCase

  def setup
    AuditSingleton.instance.enable_stdout=false
  end

  # Testing exception raising with invalid values
  def test_invalid_init_values
    assert_raises(RuntimeError,"Can't allow offers on non-integer values") {Price.new(10, 1, false, true)}
    assert_nothing_raised {Price.new(10, 1, true, false)}
    assert_nothing_raised {Price.new(10, 1, true, true)}
    assert_nothing_raised {Price.new(10, 1, false, false)}

    price_no_offer = Price.new(10, 1, true, false)
    offer = Offer.new(Date.parse('2014-12-01'),Date.parse('2014-12-10'),3,2)
    assert_raises(RuntimeError, 'Cannot assign offers to this price') {price_no_offer.special_offer = offer}
  end

  # Testing price calculation
  def test_price
    price_allowing_non_integer = Price.new(2.5)
    assert_equal(price_allowing_non_integer.calculate_price(2), 5)
    assert_equal(price_allowing_non_integer.calculate_price(2.5), 6.25)
    assert_equal(price_allowing_non_integer.calculate_price(0), 0)

    price_allowing_non_integer = Price.new(5, 2)
    assert_equal(price_allowing_non_integer.calculate_price(2), 5)
    assert_equal(price_allowing_non_integer.calculate_price(2.5), 6.25)
    assert_equal(price_allowing_non_integer.calculate_price(0), 0)

    price_allowing_integer_only = Price.new(5, 1, true)
    assert_equal(price_allowing_integer_only.calculate_price(3), 15)
    assert_raises(RuntimeError,"This price can't be calculated for non integer quantities") {price_allowing_integer_only.calculate_price(2.5)}
  end

  # Testing price calculation with offer
  def test_price_with_offer
    price = Price.new(7,1,true,true)
    offer = Offer.new(Date.parse('2000-12-01'),Date.parse('2999-12-10'),3,2)
    price.special_offer = offer
    assert_equal(price.calculate_price(10), 49)
    assert_equal(price.calculate_price(0), 0)
    assert_equal(price.calculate_price(9), 42)
  end
end