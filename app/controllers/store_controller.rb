class StoreController < ApplicationController
  def index
  	@products = Product.order(:title)
  	@visit = add_visit
  	@cart = current_cart
  end
end
