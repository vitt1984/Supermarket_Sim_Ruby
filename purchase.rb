require_relative 'product'
require_relative 'price'

class Purchase

  attr_reader :product
  attr_reader :quantity

  def initialize(product, quantity)
    @product, @quantity = product, quantity
  end

  def get_purchase_price
    @product.price.calculate_price(@quantity)
  end

  def +(other)
    raise 'Cannot add purchase of different products' unless @product == other.product
    Purchase.new(@product, @quantity + other.quantity)
  end

  def to_s
    "#{@product}: #{@quantity}"
  end

end