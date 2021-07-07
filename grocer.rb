 require 'pry'
 def consolidate_cart(cart)
  new_cart = {}
  cart.each do |element|
    element.each do |food, hash|
      if new_cart[food]
        new_cart[food][:count] += 1
      else 
        new_cart[food] = hash
        new_cart[food][:count] = 1 
      end 
    end 
  end 
  new_cart
end 


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    new_cart = "#{name} W/COUPON"
    if cart[name] && cart[name][:count] >= coupon[:num]
      cart[name][:count] -= coupon[:num]
      if cart[new_cart]
        cart[new_cart][:count] += coupon[:num] 
      else 
        cart[new_cart] = {
        :price => coupon[:cost]/coupon[:num],
        :clearance => cart[name][:clearance],
        :count => coupon[:num] 
      }
      end 
    end
  end 
  cart
end 
    

def apply_clearance(cart)
  new_cart = cart
  cart.each do |name, properties|
    if properties[:clearance] == true
      new_cart[name][:price] = (cart[name][:price] * 0.80).round(2) 
    end
  end 
  new_cart
end


def checkout(cart, coupons)
  total = 0
  new_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(new_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  clearance_cart.each do |item, attribute|
    total += (attribute[:price] * attribute[:count])
  end 
  if total > 100
    total *= 0.9
  end 
  total
end 



