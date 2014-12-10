require_relative 'lib/cashier'
require_relative 'lib/customer'
require_relative 'lib/offer'
require_relative 'lib/product'
require_relative 'lib/price'
require_relative 'lib/purchase'

# a quick example...
# Product C is used to model the price for a number of items instead of a single one
# Product D is used to model an offer
# Product E is used to model pricing by weight

product_a = Product.new('A', Price.new(7))
product_b = Product.new('B', Price.new(15, { :allow_integer_only => true }))
product_c = Product.new('C', Price.new(3,  { :quantity => 6, :allow_integer_only => true }))
product_d = Product.new('D', Price.new(10, { :allow_integer_only => true, :allow_offers => true }))
product_d.price.add_offer( Offer.new(Date.parse('2000-01-01'),Date.parse('2099-01-01'),4,3) )
product_e = Product.new('E', Price.new(0.005)) # 5 euro/kg -> 0.005 euro/g

available_products = Hash.new
available_products[product_a.name]=product_a
available_products[product_b.name]=product_b
available_products[product_c.name]=product_c
available_products[product_d.name]=product_d
available_products[product_e.name]=product_e

cashier = Cashier.new(available_products, '€')

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
customer2.add_to_cart(Purchase.new(product_e.name,500)) # 5 hg

customer3.add_to_cart(Purchase.new(product_a.name,1))
customer3.add_to_cart(Purchase.new(product_b.name,2))
customer3.add_to_cart(Purchase.new(product_c.name,20))
customer3.add_to_cart(Purchase.new(product_d.name,25))
customer3.add_to_cart(Purchase.new(product_e.name,300)) # 3 hg

cashier.handle_customer(customer1)

product_c.price = Price.new(6, { :quantity => 6, :allow_integer_only => true })

cashier.handle_customer(customer2)
cashier.handle_customer(customer3)
