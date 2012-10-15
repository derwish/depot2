class CopyProductIdToLineItem < ActiveRecord::Migration
  def up
    Cart.all.each do |cart|
      cart.line_items.each do |item|
        item.price = item.product.price
        item.save
      end
    end
  end

  def down
  end
end
