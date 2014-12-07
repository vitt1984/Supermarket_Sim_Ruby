require_relative 'audit_singleton'

class Offer

  # This class represents an offer assigned to a price
  # - period_start and period_end mark the validity interval
  # - items_threshold: this is the minimum no. of items that triggers the offer
  # - paid_items: the items that will be paid by the customer when he buys @items_threshold

  def initialize(period_start, period_end, items_threshold, paid_items)
    @period_start, @period_end, @items_threshold, @paid_items = period_start, period_end, items_threshold, paid_items
  end

  def is_valid(date)
    @period_start <= date and date <= @period_end
  end

  # Method to calculate the price based on the offer
  # items are divided in:
  # - reduced_items: the items that benefit from the reduction
  # - non_reduced_items: the rest

  def calculate_price (quantity, single_unit_price, currency='')
    reduced_items = (quantity / @items_threshold) * @paid_items
    non_reduced_items = (quantity % @items_threshold)
    reduced_price_items = reduced_items * single_unit_price
    normal_price_items  = non_reduced_items * single_unit_price
    AuditSingleton.instance.log  "Price: Reduced items #{quantity - non_reduced_items} (#{reduced_items}) * #{single_unit_price} #{currency} = #{reduced_price_items} #{currency} "
    AuditSingleton.instance.log  "Price: Non reduced items #{non_reduced_items} * #{single_unit_price} #{currency} = #{normal_price_items} #{currency}"
    reduced_price_items + normal_price_items
  end

  def to_s
    "Offer: Period: #{@period_start} - #{@period_end}. #{@items_threshold} for #{@paid_items}"
  end

end