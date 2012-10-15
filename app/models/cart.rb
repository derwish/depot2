class Cart < ActiveRecord::Base

  has_many :line_items, dependent: :destroy

  def add_product(product_id, quantity_to_add = 1)

  	current_item = line_items.find_by_product_id(product_id)

    if( current_item == nil)
      product = Product.find(product_id)
      current_item = line_items.build( product_id: product_id, quantity: quantity_to_add, price: product.price )
      logger.error "added pro"
    else
      current_item.quantity += quantity_to_add
      #logger.error "increased quantity"
    end

    current_item.save
    current_item
  end

  def remove_product( product_id, quantity_to_reduce = 0 )
    current_item = line_items.find_by_product_id(product_id)
    @removed_product = false

    if( current_item )
      if quantity_to_reduce == 0 || quantity_to_reduce >= current_item.quantity
        current_item.destroy
        @removed_product = true
      else
        current_item.quantity -= quantity_to_reduce
        current_item.save
      end        
    else
      logger.error "Can't reduce quantity for product #{product_id} "
    end
    
    return @removed_product
  end 

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def total_quantity
    line_items.to_a.sum { |item| item.quantity }
  end

  def products_quantity
    line_items.size
  end
end
