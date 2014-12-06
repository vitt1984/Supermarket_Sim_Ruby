require_relative 'lib/cashier'
require_relative 'lib/customer'
require_relative 'lib/offer'
require_relative 'lib/product'
require_relative 'lib/price'
require_relative 'lib/purchase'

# a quick example...

product_a = Product.new('A', Price.new(7))
product_b = Product.new('B', Price.new(15,1,true))
product_c = Product.new('C', Price.new(3,6,true))
product_d = Product.new('D', Price.new(10,1,true,true))
product_d.price.special_offer = Offer.new(Date.parse('2000-01-01'),Date.parse('2099-01-01'),4,3)

available_products = Hash.new
available_products[product_a.name]=product_a
available_products[product_b.name]=product_b
available_products[product_c.name]=product_c
available_products[product_d.name]=product_d

cashier = Cashier.new(available_products)

customer1 = Customer.new('C1')
customer2 = Customer.new('C2')
customer3 = Customer.new('C3')

customer1.add_to_cart(Purchase.new(product_a.name,5.5))
customer1.add_to_cart(Purchase.new(product_b.name,2))
customer1.add_to_cart(Purchase.new(product_c.name,4))
customer1.add_to_cart(Purchase.new(product_b.name,4))
customer1.add_to_cart(Purchase.new(product_d.name,16))

customer2.add_to_cart(Purchase.new(product_a.name,3.5))
customer2.add_to_cart(Purchase.new(product_b.name,1))
customer2.add_to_cart(Purchase.new(product_c.name,2))

customer3.add_to_cart(Purchase.new(product_a.name,1))
customer3.add_to_cart(Purchase.new(product_b.name,2))
customer3.add_to_cart(Purchase.new(product_c.name,20))
customer3.add_to_cart(Purchase.new(product_d.name,25))

cashier.handle_customer(customer1)

product_c.price = Price.new(6,6,true)

cashier.handle_customer(customer2)
cashier.handle_customer(customer3)
