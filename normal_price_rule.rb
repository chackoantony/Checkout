# This class is responsible for calculating the total
# for products without any promotions.
class NormalPriceRule
  def initialize
    @items = []
  end

  def add_item(product)
    @items << product
  end

  def total
    @items.inject(0) { |sum, item| sum + item['price'].to_f }
  end
end
