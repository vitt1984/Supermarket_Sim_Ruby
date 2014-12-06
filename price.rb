require_relative 'offer'
require_relative 'audit_singleton'
require 'Date'

class Price

  # This class models the pricing system
  # - allow_integer_only: bool, if true raises an exception when asking to calculate price for non-integer quantity
  # - allow_offers: bool, if true offer cannot be assigned to this price
  # - price_by_quantity: the price for a single unit
  #   note that this can be used also for units of weight as long as they are converted to the base value
  #   of each weight unit. For instance, a price of 3 euro per kg could be modeled as 0.003 euro per g
  #   this answers the requirement of the exercise
  # - special_offer: class Offer, this allows for implementation of time based special offers

  attr_reader :allow_integer_only, :allow_offers
  attr_reader :price_by_quantity
  attr_accessor :special_offer

  def initialize(price, quantity = 1, allow_integer_only = false, allow_offers = false)
    raise "Can't allow offers on non-integer values" if allow_offers and not allow_integer_only
    price_by_quantity = price.to_f/quantity
    @price_by_quantity, @allow_integer_only, @allow_offers = price_by_quantity, allow_integer_only, allow_offers
  end

  # This method calculates the price for a quantity:
  # if an offer is available, the calculation is handed over to the @special_offer field
  # if not, the calculation is done directy by using the @price_by_quantity value
  # there are also checks that raise exceptions for invalid values

  def calculate_price (quantity)
    raise 'This quantity is not a number' unless quantity.is_a? Numeric
    raise "This price can't be calculated for non integer quantities" if @allow_integer_only and not quantity.is_a? Integer

    if not @special_offer.nil? and @special_offer.is_valid(Date.today)
      AuditSingleton.instance.log  "Offer: #{@special_offer}"
      price = @special_offer.calculate_price(quantity, @price_by_quantity)
    else
      price = @price_by_quantity * quantity
      AuditSingleton.instance.log  "Price: #{@price_by_quantity} * #{quantity} = #{price}"
    end
    price
  end

  def special_offer=(offer)
    raise 'Cannot assign offers to this price' unless allow_offers
    @special_offer=offer
  end

  def to_s
    "Price: #{@price_by_quantity}, Integer only: #{@allow_integer_only}, Offers allowed: #{@allow_offers}. #{@special_offer}"
  end

end

