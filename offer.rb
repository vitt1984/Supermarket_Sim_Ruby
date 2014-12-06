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
    reducedPriceItems = (quantity / @itemsThreshold) * @offeredItemsForThreshold * priceByQuantity
    normalPriceItems  = (quantity % @itemsThreshold) * priceByQuantity
    price = reducedPriceItems + normalPriceItems
  end

  def to_s
    # TODO
  end

end