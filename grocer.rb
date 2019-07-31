def consolidate_cart(cart)
  # code here
  orgCart = {}
  cart.each{|hash|
    hash.each{|iteam, detail|
      if !orgCart.has_key?(iteam)
        orgCart[iteam] = detail
        orgCart[iteam][:count] = 1
      else
        orgCart[iteam][:count] += 1
      end
    }
  }
  orgCart
end

def apply_coupons(cart, coupons)
  # code here
  coup_count = 0
  coupons.each{ |coup_hash|
    if cart.has_key?(coup_hash[:item]) && cart[coup_hash[:item]][:count]>=coup_hash[:num] && !cart.has_key?("#{coup_hash[:item]} W/COUPON")
      cart[coup_hash[:item]][:count]-=coup_hash[:num]
      nPrice = coup_hash[:cost]/coup_hash[:num]
      cart["#{coup_hash[:item]} W/COUPON"] = {price: nPrice, clearance: cart[coup_hash[:item]][:clearance], count: coup_hash[:num] }
    elsif cart.has_key?(coup_hash[:item]) && cart[coup_hash[:item]][:count]>=coup_hash[:num] && cart.has_key?("#{coup_hash[:item]} W/COUPON")
      coup_count +=1
      cart[coup_hash[:item]][:count]-=coup_hash[:num]
      cart["#{coup_hash[:item]} W/COUPON"][:count]+= coup_hash[:num]
    end
  }
  cart
end

def apply_clearance(cart)
  # code here
  cart.each{|hash|
    if hash[1][:clearance] == true
      hash[1][:price] -= (hash[1][:price]*0.2)
    end
  }
end

def checkout(cart, coupons)
  # code here
  total = 0
  nCart = consolidate_cart(cart)
  coup_cart = apply_coupons(nCart, coupons)
  clear_coup_cart = apply_clearance(coup_cart)
  
  clear_coup_cart.each{|hash|
    total+=(hash[1][:price]*hash[1][:count])
  }
  
  if total>100
    total -= (total*0.1)
  end
  total
end
