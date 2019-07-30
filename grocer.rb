require 'pry'
def consolidate_cart(cart)
  consolidated = {}
  cart.each do |item|
    if !consolidated[item.keys[0]]
      consolidated[item.keys[0]] = {
        price: item.values[0][:price],
        clearance: item.values[0][:clearance],
        count: 1
      }
      #binding.pry
    else
      consolidated[item.keys[0]][:count] += 1
    end
  end
  consolidated
end


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        new_item= "#{coupon[:item]} W/COUPON"
        if cart[new_item]
          cart[new_item][:count] += coupon[:num]
        else
          #cart[new_name][:count] += coupon[:num]
        #else
          cart[new_item] = {
          :price => coupon[:cost] / coupon[:num],
          :clearance => cart[coupon[:item]][:clearance],
          :count => coupon[:num]
        }
      end
        cart[coupon[:item]][:count] -=coupon[:num]
#binding.pry
        #item_coupon = "#{coupon[:item]} W/COUPON"
        end
      end
      end
      cart
    end



  def apply_clearance(cart)
    cart.keys.each do |item|
      if cart[item][:clearance]
        cart[item][:price] = (cart[item][:price] * 0.8).round(2)
      end
    end
    cart
  end


  def checkout(cart, coupons)
    total = 0.0
    cart = consolidate_cart(cart)
    cart = apply_coupons(cart, coupons)
    #binding.pry
    cart = apply_clearance(cart)

    cart.keys.each do |item|
      total += cart[item][:price] * cart[item][:count]
    end
    if total > 100.100
      total = (total * 0.9).round(2)
    end
    total
  end
