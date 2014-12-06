require_relative 'customer'

class Cashier

  def self.handle_customer(customer)

    merged_items = merge_items(customer.items)

    price = 0.0
    merged_items.each do |item|
      price += item.get_purchase_price
    end

    puts customer, "needs to pay", price
  end

  def self.merge_items(items)
    merged_items = Hash.new 0
    items.each do |item|
      merged_items.has_key?(item.product.name) ?
          merged_items[item.product.name] += item :
          merged_items[item.product.name] = item
    end
    merged_items
  end

end