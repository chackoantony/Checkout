require 'json'
require_relative 'normal_price_rule'

# Main checkout class
class Checkout
  def initialize(promo_rules)
    # Read product price info.
    @products = JSON.parse(File.read(Dir.pwd + '/products.json'))
    @promo_rules = promo_rules
    @normal_price_rule = NormalPriceRule.new
  end

  def scan(item)
    product = @products.find { |p| p['sku'] == item }
    return  unless product # Skipping invalid items
    promo = @promo_rules.find { |rule| rule.valid? product }
    promo ? promo.add_item(product) : @normal_price_rule.add_item(product)
  end

  def total
    @promo_rules.inject(0) { |sum, promo| sum + promo.total } + @normal_price_rule.total
  end
end
