require_relative 'purchase'

class Customer

  attr_reader :name
  attr_reader :items

  def initialize(name)
    @name = name
    @items = Array.new
  end

  def add_to_cart(item)
    @items.push(item)
  end

  def to_s
    @name
  end

end