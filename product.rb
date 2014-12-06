class Product

  attr_reader :name
  attr_reader :price

  def initialize(name, price)
    @name, @price = name, price
  end

  def ==(other)
    @name == other.name
  end

  def to_s
    @name
  end

end