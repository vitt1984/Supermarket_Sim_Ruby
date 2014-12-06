require_relative 'product'
require_relative 'price'

class Purchase

  attr_reader :name
  attr_reader :quantity

  def initialize(name, quantity)
    @name, @quantity = name, quantity
  end

  def +(other)
    raise 'Cannot add purchase of different products' unless @name == other.name
    Purchase.new(@name, @quantity + other.quantity)
  end

  def to_s
    "#{@name}: #{@quantity}"
  end

end