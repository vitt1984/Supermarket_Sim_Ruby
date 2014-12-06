require_relative 'offer'
require 'Date'

class Price

  attr_reader :allow_integer_only, :allow_offers
  attr_reader :price_by_quantity
  attr_writer :special_offer

  def initialize(price, quantity = 1, allow_integer_only = false, allow_offers = false)
    raise "Can't allow offers on non-integer values" if allow_offers and not allow_integer_only
    price_by_quantity = price.to_f/quantity
    @price_by_quantity, @allow_integer_only, @allow_offers = price_by_quantity, allow_integer_only, allow_offers
  end

  def calculate_price (quantity)
    raise 'This quantity is not a number' unless quantity.is_a? Numeric
    raise "This price can't be calculated for non integer quantities" if @allow_integer_only and not quantity.is_a? Integer

    if not @special_offer.nil? and @special_offer.is_valid(Date.today)
      puts "Offer: #{@special_offer}"
      price = @special_offer.calculate_price(quantity, @price_by_quantity)
    else
      price = @price_by_quantity * quantity
      puts "Price: #{@price_by_quantity} * #{quantity} = #{price}"
    end
    price
  end

  def to_s
    # TODO
  end

end

