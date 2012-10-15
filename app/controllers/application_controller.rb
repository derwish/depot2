class ApplicationController < ActionController::Base
  protect_from_forgery

private
	def current_cart
		Cart.find(session[:cart_id])
		rescue ActiveRecord::RecordNotFound
		cart = Cart.create
		session[:cart_id] = cart.id
		cart
	end

	def add_visit
		session[:counter] ? session[:counter] += 1 : session[:counter] = 0
	end

	def reset_visit
		session[:counter] = 0
	end	
end
