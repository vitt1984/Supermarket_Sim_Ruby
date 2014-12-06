require_relative 'cashier'
require_relative 'customer'
require_relative 'offer'
require_relative 'product'
require_relative 'price'
require_relative 'purchase'

product_a = Product.new('A', Price.new(7))
product_b = Product.new('B', Price.new(15,1,true))
product_c = Product.new('C', Price.new(3,6,true))
product_d = Product.new('D', Price.new(10,1,true,true))
product_d.price.special_offer = Offer.new(Date.parse('2000-01-01'),Date.parse('2099-01-01'),4,3)

customer1 = Customer.new('C1')
customer2 = Customer.new('C2')
customer3 = Customer.new('C3')

customer1.add_to_cart(Purchase.new(product_a,5.5))
customer1.add_to_cart(Purchase.new(product_b,2))
customer1.add_to_cart(Purchase.new(product_c,4))
customer1.add_to_cart(Purchase.new(product_b,4))
customer1.add_to_cart(Purchase.new(product_d,16))

Cashier.handle_customer(customer1)
