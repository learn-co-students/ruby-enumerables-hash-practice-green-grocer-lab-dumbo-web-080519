def consolidate_cart(cart)
  new_cart = {}
  cart.each do |item|
    if !new_cart[item.keys[0]]
      new_cart[item.keys[0]] = {
        count: 1,
        price: item.values[0][:price],
        clearance: item.values[0][:clearance]
      }
    else 
      new_cart[item.keys[0]][:count] += 1
    end
  end 
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item])
      if cart[coupon[:item]][:count] >= coupon[:num]
        new_name = "#{coupon[:item]} W/COUPON"
        if !cart[new_name]
          cart[new_name] = {
            count: coupon[:num],
            price: coupon[:cost] / coupon[:num],
            clearance: cart[coupon[:item]][:clearance]
          }
        else
          cart[new_name][:count] += coupon[:num]
        end
        cart[coupon[:item]][:count] -= coupon[:num]
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
  cart = apply_clearance(cart)
  cart.keys.each do |item|
    total += cart[item][:price] * cart[item][:count]
  end
  if total > 100.100
    total = (total * 0.9).round(2)
  end
  total
end
