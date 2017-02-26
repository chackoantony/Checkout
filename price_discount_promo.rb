# This class is responsible for calculating the total
# for products with price discount promotion.
class PriceDiscountPromo
  def initialize(sku, quantity, promo_price)
    @sku = sku
    @quantity = quantity
    @promo_price = promo_price
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def valid? product
    @sku == product['sku']
  end  

  def total
    return 0 if @items.empty?
    item_count = @items.length
    (item_count / @quantity * @promo_price) + ((item_count % @quantity) * @items.first['price'].to_f)
  end
end
