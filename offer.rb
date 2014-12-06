class Offer

  attr_reader :periodStart, :periodEnd
  attr_reader :itemsThreshold
  attr_reader :offeredItemsForThreshold

  def initialize(periodStart, periodEnd, itemsThreshold, offeredItemsForThreshold)
    @periodStart, @periodEnd, @itemsThreshold, @offeredItemsForThreshold = periodStart, periodEnd, itemsThreshold, offeredItemsForThreshold
  end

  def isValid(date)
    @periodStart <= date and date <= @periodEnd
  end

  def calculatePrice (quantity, priceByQuantity)
    reducedItems = (quantity / @itemsThreshold) * @offeredItemsForThreshold
    nonReducedItems = (quantity % @itemsThreshold)
    reducedPriceItems = reducedItems * priceByQuantity
    normalPriceItems  = nonReducedItems * priceByQuantity
    puts "Price: Reduced items #{quantity - nonReducedItems} paid as #{reducedPriceItems}"
    puts "Price: Non reduced items #{nonReducedItems} paid as #{normalPriceItems}"
    price = reducedPriceItems + normalPriceItems
  end

  def to_s
    "Offer: Today: #{Date.today} Period: #{periodStart} - #{periodEnd}. #{@itemsThreshold} for #{@offeredItemsForThreshold}"
  end

end