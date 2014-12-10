require_relative 'offer'
require_relative 'audit_singleton'
require 'Date'

class Price

  # This class models the pricing system
  # - allow_integer_only: bool, if true raises an exception when asking to calculate price for non-integer quantity
  # - allow_offers: bool, if true offer cannot be assigned to this price
  # - single_unit_price: the price for a single unit
  #   note that this can be used also for units of weight as long as they are converted to the base value
  #   of each weight unit. For instance, a price of 3 euro per kg could be modeled as 0.003 euro per g
  #   this answers the requirement of the exercise
  # - offers: Array of Offers, this allows for implementation of time based special offers

  attr_reader :offers

  def initialize(price, options = {})
    options = {
        :quantity => 1,
        :allow_integer_only => false,
        :allow_offers => false,
    }.merge(options)

    @offers = Array.new

    @single_unit_price = price.to_f/options[:quantity]
    @allow_integer_only, @allow_offers = options[:allow_integer_only], options[:allow_offers]

    raise "Can't allow offers on non-integer values" if @allow_offers and !@allow_integer_only
  end

  # This method calculates the price for a quantity:
  # if an offer is available, the calculation is handed over to the @special_offer field
  # TODO for now if more than one is available, take the last one. Improve behaviour later
  # if not, the calculation is done directly by using the @price_by_quantity value
  # there are also checks that raise exceptions for invalid values

  def calculate_price (quantity, options = {})
    options = {
        :currency => ''
    }.merge(options)

    currency = options[:currency]

    raise 'This quantity is not a number' unless quantity.is_a? Numeric
    raise "This price can't be calculated for non integer quantities" if @allow_integer_only and !quantity.is_a? Integer

    applicable_offer = @offers.select { |offer| offer.valid?(Date.today) }.last
    price = if applicable_offer
              AuditSingleton.instance.log  "Offer: #{applicable_offer}"
              applicable_offer.calculate_price(quantity, @single_unit_price, options)
            else
              AuditSingleton.instance.log  "Price: #{@single_unit_price} #{currency}"\
                                           "* #{quantity} = #{(@single_unit_price * quantity)} #{currency}"
              @single_unit_price * quantity
            end
  end

  def add_offer(offer)
    raise 'Cannot assign offers to this price' unless @allow_offers
    @offers << offer
  end

  def clear_offers(offer)
    @offers.clear
  end

  def to_s
    "Price: #{@single_unit_price}, Integer only: #{@allow_integer_only}, "\
    "Offers allowed: #{@allow_offers}. #{@special_offer}"
  end

end

