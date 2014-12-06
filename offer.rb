class Offer

  attr_reader :period_start, :period_end
  attr_reader :items_threshold
  attr_reader :paid_items

  def initialize(period_start, period_end, items_threshold, paid_items)
    @period_start, @period_end, @items_threshold, @paid_items = period_start, period_end, items_threshold, paid_items
  end

  def is_valid(date)
    @period_start <= date and date <= @period_end
  end

  def calculate_price (quantity, price_by_quantity)
    reduced_items = (quantity / @items_threshold) * @paid_items
    non_reduced_items = (quantity % @items_threshold)
    reduced_price_items = reduced_items * price_by_quantity
    normal_price_items  = non_reduced_items * price_by_quantity
    puts "Price: Reduced items #{quantity - non_reduced_items} = #{reduced_price_items}"
    puts "Price: Non reduced items #{non_reduced_items} = #{normal_price_items}"
    reduced_price_items + normal_price_items
  end

  def to_s
    "Offer: Today: #{Date.today} Period: #{period_start} - #{period_end}. #{@items_threshold} for #{@paid_items}"
  end

end