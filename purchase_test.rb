require 'test/unit'
require_relative 'product'
require_relative 'price'
require_relative 'purchase'
require_relative 'offer'

class PurchaseTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_sum
    purchase1 = Purchase.new("A",15)
    purchase2 = Purchase.new("A",20)
    assert_equal((purchase1+purchase2).quantity,35)
  end

  def test_invalid_sum
    purchase1 = Purchase.new("A",15)
    purchase2 = Purchase.new("B",20)
    assert_raises(RuntimeError,"Cannot add purchase of different products") {purchase1+purchase2}
  end

end