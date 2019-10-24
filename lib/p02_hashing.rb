class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    hashable_int = 0 
    each_with_index{ |val, i| hashable_int += (val.ord^i) }
    hashable_int.hash
  end
end

class String
  def hash
    split("").hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hashable_int = 0
    each { |k,v| hashable_int += k.to_s.hash * v.to_s.hash }
    hashable_int.hash
  end
end
