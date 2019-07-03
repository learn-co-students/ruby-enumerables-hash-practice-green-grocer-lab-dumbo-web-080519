def consolidate_cart(cart)
  consolidated = {}
  
  cart.each do |item|
    name = item.keys[0]
    if consolidated.has_key?(name)
      consolidated[name][:count] += 1
    else
      consolidated[name] = item[name]
      consolidated[name][:count] = 1
    end
  end
  
  consolidated
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    coupon_item = coupon[:item]
    
    
    if cart.has_key?(coupon_item) && cart[coupon_item][:count] >= coupon[:num]
      
      # remove items from standard price
      cart[coupon_item][:count] -= coupon[:num]
      
      # create new key for discounted items if necessary
      coupon_name = coupon_item + " W/COUPON"
      
      if cart.has_key?(coupon_name)
        cart[coupon_name][:count] += coupon[:num]
      else
        cart[coupon_name] = {
          price: coupon[:cost] / coupon[:num],
          clearance: cart[coupon_item][:clearance],
          count: coupon[:num]
        }
      end
      
    end
  end
  
  cart
end

def apply_clearance(cart)
  cart.each do |name, info|
    info[:price] = (info[:price] * 0.80).round(2) if info[:clearance]
  end
  
  cart
end

def checkout(cart, coupons)
  final_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  prices = []
  
  final_cart.each do |item, item_info|
    prices << item_info[:price] * item_info[:count]
  end
  
  final = prices.reduce { |a, b| a + b}
  
  final > 100 ? final * 0.9 : final
  
end
