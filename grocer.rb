require "pry"
def consolidate_cart(cart)
  new_cart = {}
  cart.each do |item|
    item.each do |name, attributes|
      if new_cart.has_key?(name)
        new_cart[name][:count] += 1
      else
        new_cart[name] = attributes
        new_cart[name][:count] = 1
      end
    end
  end

  return new_cart
end


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.has_key?(coupon[:item]) && cart[coupon[:item]][:count] >= coupon[:num]
      cart[coupon[:item]][:count] -= coupon[:num]
      new_name = "#{coupon[:item]} W/COUPON"
      if cart.has_key?(new_name)
        cart[new_name][:count] += coupon[:num]
      else
        cart[new_name] = {
          count: coupon[:num],
          price: coupon[:cost] / coupon[:num],
          clearance: cart[coupon[:item]][:clearance]
        }
      end
    end
  end
  return cart
end

def apply_clearance(cart)
  cart.keys.each do |item|
      if cart[item][:clearance]
        cart[item][:price] = (cart[item][:price] * 0.8).round(2)
      end
  end

  return cart
end

def checkout(cart, coupons)
  checkout_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(checkout_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)

  total = 0
  clearance_cart.each do | key, value |
    total += value[:price] * value[:count]
  end

  if total >= 100
    total = total * 0.9
  end

  return total
end
