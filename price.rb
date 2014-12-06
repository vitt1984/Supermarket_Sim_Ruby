
require_relative 'offer'
require 'Date'

class Price

  attr_reader :allowIntegerOnly, :allowOffers
  attr_reader :priceByQuantity
  attr_writer :specialOffer

  def initialize(price, quantity = 1, allowIntegerOnly = false, allowOffers = false)
    raise "Can't allow offers on non-integer values" if allowOffers and not allowIntegerOnly
    priceByQuantity = price.to_f/quantity
    @priceByQuantity, @allowIntegerOnly, @allowOffers = priceByQuantity, allowIntegerOnly, allowOffers
  end

  def calculatePrice (quantity)
    raise "This quantity is not a number" if not quantity.is_a? Numeric
    raise "This price can't be calculated for non integer quantities" if @allowIntegerOnly and not quantity.is_a? Integer
    if @specialOffer.nil? or @specialOffer.isValid(Date.today)
      price = @priceByQuantity * quantity
    else
      price = @specialOffer.calculatePrice(quantity, @priceByQuantity)
    end
  end

  def to_s
    # TODO
  end

end

