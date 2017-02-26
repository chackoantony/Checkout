require 'minitest/autorun'
require_relative 'checkout'
require_relative 'price_discount_promo'

class TestCheckout < MiniTest::Test
  
  def test_totals
    assert_equal(0, price(''))
    assert_equal(50, price('A'))
    assert_equal(80, price('AB'))
    assert_equal(115, price('CDBA'))

    assert_equal(100, price('AA'))
    assert_equal(130, price('AAA'))
    assert_equal(180, price('AAAA'))
    assert_equal(230, price('AAAAA'))
    assert_equal(260, price('AAAAAA'))

    assert_equal(160, price('AAAB'))
    assert_equal(175, price('AAABB'))
    assert_equal(190, price('AAABBD'))
    assert_equal(190, price('DABABA'))
  end

  def test_incremental
    co = Checkout.new(PriceDiscountPromo.new('A', 3, 130), PriceDiscountPromo.new('B', 2, 45))
    assert_equal(0, co.total)
    co.scan('A')
    assert_equal(50, co.total)
    co.scan('B')
    assert_equal(80, co.total)
    co.scan('A')
    assert_equal(130, co.total)
    co.scan('A')
    assert_equal(160, co.total)
    co.scan('B')
    assert_equal(175, co.total)
  end

  def price(goods)
    co = Checkout.new(PriceDiscountPromo.new('A', 3, 130), PriceDiscountPromo.new('B', 2, 45)) 
    goods.split(//).each { |item| co.scan(item) }
    co.total
  end
end
