require 'test/unit'
require_relative '../lib/purchase'

class PurchaseTest < Test::Unit::TestCase

  def setup
    AuditSingleton.instance.enable_stdout=false
  end

  # Testing overloading of + operator
  def test_sum
    purchase1 = Purchase.new('A',15)
    purchase2 = Purchase.new('A',20)
    assert_equal((purchase1+purchase2).quantity,35)
  end

  # Testing exception raising from + operator
  def test_invalid_sum
    purchase1 = Purchase.new('A',15)
    purchase2 = Purchase.new('B',20)
    assert_raises(RuntimeError, 'Cannot add purchase of different products') {purchase1+purchase2}
  end

  def test_invalid_quantity
    assert_raises(RuntimeError, 'Quantity should be a positive number') {Purchase.new('A',-1)}
    assert_raises(RuntimeError, 'Quantity should be a positive number') {Purchase.new('A',0)}
  end

end