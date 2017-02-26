class PriceDiscountPromo

  attr_accessor :sku	

  def initialize(sku, quantity, promo_price)
    @sku = sku
    @quantity = quantity
    @promo_price = promo_price
    @items = []
  end

  def add_item item
  	@items << item
  end 	
  
  def total
  	(@items.length / @quantity * @promo_price) + ((@items.length % @quantity) * @items.first['price'])
  end  
  
end
