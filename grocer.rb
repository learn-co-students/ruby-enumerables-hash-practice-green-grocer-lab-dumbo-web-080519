require "pry"


def consolidate_cart(cart)
  updated_cart = {}
  cart.each do |item_hash|
    item_hash.each do |item_name, item_info| # item_name = "avocado", item_info = {price: 3.00, clearance: true}
      if !updated_cart.key?(item_name)
        updated_cart[item_name] = item_info
        updated_cart[item_name][:count] = 1
      else
        updated_cart[item_name][:count] += 1
      end
    end
  end
  updated_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item])
      if cart[coupon[:item]][:count] >= coupon[:num]
        discount = "#{coupon[:item]} W/COUPON"
        if cart[discount]
          cart[discount][:count] += coupon[:num]
        else
          cart[discount] = {
            :price => coupon[:cost] / coupon[:num],
            :clearance => cart[coupon[:item]][:clearance],
            :count => coupon[:num]
          }
        end
        cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, item_detail|
    if item_detail[:clearance] == true
      item_detail[:price] = (item_detail[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart1 = apply_coupons(cart, coupons)
  cart2 = apply_clearance(cart)
  total = 0
  
  cart2.each do |name, price_hash|
    total += price_hash[:price] * price_hash[:count]
  end
  if total > 100
    total = (total * 0.9).round(2)
  else
    total.round(2)
  end
  
end

## consolidate_cart
# check if updated_cart has the item_name, if it doesnt, add it to updated_cart with the count as 1
# check if updated cart has the item_name, if it does, increment the count of the item

## apply_coupons
