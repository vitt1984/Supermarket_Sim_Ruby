require 'test/unit'
require_relative 'product'
require_relative 'price'
require_relative 'purchase'
require_relative 'offer'

class PurchaseTest < Test::Unit::TestCase

  # Testing overloading of + operator
  def test_sum
    purchase1 = Purchase.new("A",15)
    purchase2 = Purchase.new("A",20)
    assert_equal((purchase1+purchase2).quantity,35)
  end

  # Testing exception raising from + operator
  def test_invalid_sum
    purchase1 = Purchase.new("A",15)
    purchase2 = Purchase.new("B",20)
    assert_raises(RuntimeError,"Cannot add purchase of different products") {purchase1+purchase2}
  end

end