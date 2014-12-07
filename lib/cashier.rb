require_relative 'customer'
require_relative 'audit_singleton'

class Cashier

  # This class models a cashier
  # - available_products: the list of the products available (each Product contains a price)
  #   can be reassigned to model changing prices

  attr_accessor :available_products

  def initialize(available_products, currency)
    @available_products = available_products
    @currency = currency
  end

  # This method handles a customer's items
  # First all items are merged in a single Hash
  # Then each item from Hash is compared against the @available_products to obtain the price
  # Returns the total the customer has to pay

  def handle_customer(customer)
    AuditSingleton.instance.log "#{customer} checking out..."
    merged_items = merge_items(customer.items)

    total = 0.0
    merged_items.values.each do |item|
      AuditSingleton.instance.log  "Scanning #{item.name} #{item}"
      raise "Product #{item.name} is not registered" unless @available_products.has_key?(item.name)
      total += @available_products[item.name].price.calculate_price(item.quantity, @currency)
    end
    AuditSingleton.instance.log  "#{customer} needs to pay #{total} #{@currency}"
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