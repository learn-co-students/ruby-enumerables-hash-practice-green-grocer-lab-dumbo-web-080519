# - Access and iterate over hashes
# - Translate data from arrays to hashes
# - Translate data from hashes to other hashes
# - Count repeat items in a hash
# - Perform calculations based on hash data


ddef consolidate_cart(cart)
  new_cart = {}
  cart.each do |element|
    element.each do |fruit, hash|
      organized_cart[fruit] ||= hash
      organized_cart[fruit][:count] ||= 0
      organized_cart[fruit][:count] += 1
    end
  end
  return organized_cart
end


def apply_coupons(cart, coupons)
  # code here
  
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
