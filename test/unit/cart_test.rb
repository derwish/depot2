require 'test_helper'

class CartTest < ActiveSupport::TestCase
	fixtures :products

	test "new cart has zero total_price" do
		cart = Cart.new
		
		assert_in_delta cart.total_price, 0, 0.01
	end

	test "adding product adds line_item to cart" do
		cart = Cart.new
		
		cart.save
		cart.add_product( products(:ruby) )

		assert_in_delta cart.total_price, products(:ruby).price, 0.01,
		"\nexpected #{products(:ruby).price}
		 \nreceived #{cart.total_price}"
		#assert_size( cart.line_items, 0 )
	end

	test "adding product increase quantity of items in cart" do
		cart = Cart.new

		cart.save
		cart.add_product( products(:ruby) )
		
		assert_equal cart.total_quantity(), 1	
	end

	test "adding unique products increase total_price of the cart" do
		cart = Cart.new

		cart.save
		cart.add_product( products(:ruby) )
		cart.add_product( products(:one) )
		
		assert_in_delta cart.total_price, products(:ruby).price + products(:one).price, 0.01
	end

	test "adding unique products adds line items" do
		cart = Cart.new

		cart.save
		cart.add_product( products(:ruby) )
		cart.add_product( products(:one) )

		assert_size( cart.line_items, 2 )
	end

	test "adding duplicated products do not add line items" do
		cart = Cart.new

		cart.save
		cart.add_product( products(:ruby).id )
		cart.add_product( products(:ruby).id )
		cart.save

		assert_size( cart.line_items, 1 )
	end

	test "adding duplicated products increases twice total_price of the cart" do
		cart = Cart.new

		cart.save
		cart.add_product( products(:ruby).id )
		cart.add_product( products(:ruby).id )
		cart.save

		assert_in_delta cart.total_price, 2*products(:ruby).price, 0.01,
		"\nexpected ruby #{2*products(:ruby).price}
		 \nreceived #{cart.total_price}"
	end

	test "adding duplicated products increases quantity in line_item corresponding to that product" do
		cart = Cart.new

		cart.save
		cart.add_product( products(:ruby).id )
		cart.add_product( products(:ruby).id )
		cart.save

		assert_equal cart.line_items[0].quantity, 2,
		"\nexpected cart ---- #{cart.total_quantity} ---- received 2"
	end
end
