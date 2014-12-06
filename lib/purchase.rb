class Purchase

  # This class represents a single purchase performed by a customer
  # - name: name of the product purchased. This is later used to match this purchase against a price
  # - quantity: number of units (see Price class for better description)

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