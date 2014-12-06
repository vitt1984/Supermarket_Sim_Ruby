require_relative 'customer'

class Cashier

  attr_reader :available_products

  def initialize(available_products)
    @available_products = available_products
  end

  def handle_customer(customer)
    puts "#{customer} checking out..."
    merged_items = merge_items(customer.items)

    total = 0.0
    merged_items.values.each do |item|
      puts "Scanning #{item.name} #{item}"
      total += @available_products[item.name].price.calculate_price(item.quantity)
    end
    puts "#{customer} needs to pay #{total}"
    total
  end

  def merge_items(items)
    merged_items = Hash.new
    items.each do |item|
      merged_items.has_key?(item.name) ?
          merged_items[item.name] += item :
          merged_items[item.name] = item
    end
    merged_items
  end

end