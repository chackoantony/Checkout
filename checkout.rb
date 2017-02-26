require 'json'

class Checkout

  def initialize(promo_rules)
    @products = JSON.parse(File.read(Dir.pwd + '/products.json'))
    @promo_rules = promo_rules
    @non_promo_items = []
  end

  def scan(item)
    product = @products.find{|product| product['sku'] == item }
    raise "Invalid Item" unless product
    promo = @promo_rules.find{|rule| rule.sku == item}
    if promo
      promo.add_item product
    else
      @non_promo_items << product
    end    
  end

  def total
    promo_price = @promo_rules.inject(0){|sum, promo| sum  + promo.total }
    promo_price + @non_promo_items.inject(0){|sum, item| sum + item['price']}
  end
 
end
