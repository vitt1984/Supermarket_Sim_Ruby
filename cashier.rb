require_relative 'customer'

class Cashier

  # This class models a cashier
  # - available_products: the list of the products available (each Product contains a price)
  #   can be reassigned to model changing prices

  attr_writer :available_products

  def initialize(available_products)
    @available_products = available_products
  end

  # This method handles a customer's items
  # First all items are merged in a single Hash
  # Then each item from Hash is compared against the @available_products to obtain the price
  # Returns the total the customer has to pay

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

  # This method merges the items (Purchase) provided by a customer by name

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