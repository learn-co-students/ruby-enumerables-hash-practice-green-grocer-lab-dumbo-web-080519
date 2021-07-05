require 'pry'
def consolidate_cart(cart)
  # code here
  new_cart = {}
  cart.each do |hash|
    hash.each do |name, describe|
      if new_cart[name]
        new_cart[name][:count] += 1
      else
        new_cart[name] = describe
        new_cart[name][:count] = 1
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  return cart if coupons == []
  new_cart = cart

  coupons.each do |coupon|
    name = coupon[:item]
    coupon_num = coupon[:num]
    coupon_cost = coupon[:cost]
    if cart.include?(name) && cart[name][:count] >= coupon_num
       new_cart[name][:count] -= coupon_num
       if new_cart["#{name} W/COUPON"]
         new_cart["#{name} W/COUPON"][:price] = coupon_cost / coupon_num
         new_cart["#{name} W/COUPON"][:count] += coupon_num
       else
         new_cart["#{name} W/COUPON"] = {
           :price => coupon_cost / coupon_num,
           :clearance => new_cart[name][:clearance],
           :count => coupon_num}
       end
     end
   end
   new_cart
end

def apply_clearance(cart)
  new_cart = cart
  cart.each do |name, hash|
      if hash[:clearance]
        new_cart[name][:price] = (cart[name][:price] * 0.8).round(1)
      end
  end
  new_cart
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)

  total = 0
  new_cart.each do |name, hash|
    total += (hash[:price] * hash[:count])
  end

if total >= 100
    total *= 0.9
  end
  total
end
