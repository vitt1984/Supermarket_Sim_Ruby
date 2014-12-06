require 'test/unit'
require_relative 'price'

class PriceTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_invalid_init_values
    assert_raises(RuntimeError,"Can't allow offers on non-integer values") {Price.new(10, 1, false, true)}
    assert_nothing_raised {Price.new(10, 1, true, false)}
    assert_nothing_raised {Price.new(10, 1, true, true)}
    assert_nothing_raised {Price.new(10, 1, false, false)}
  end

  def test_price
    price_allowing_non_integer = Price.new(2.5)
    assert_equal(price_allowing_non_integer.calculate_price(2), 5)
    assert_equal(price_allowing_non_integer.calculate_price(2.5), 6.25)

    price_allowing_non_integer = Price.new(5, 2)
    assert_equal(price_allowing_non_integer.calculate_price(2), 5)
    assert_equal(price_allowing_non_integer.calculate_price(2.5), 6.25)

    price_allowing_integer_only = Price.new(5, 1, true)
    assert_equal(price_allowing_integer_only.calculate_price(3), 15)
    assert_raises(RuntimeError,"This price can't be calculated for non integer quantities") {price_allowing_integer_only.calculate_price(2.5)}
  end

  def test_price_with_offer
    # TODO
  end
end