class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hold = 0
    self.each_with_index do |e, idx|
      hold += (e.hash * idx.hash)
    end
    hold
  end
end

class String
  def hash
    arr = self.chars
    hold = 1
    arr.each_with_index do |e, idx|
      hold += e.ord.hash / idx.hash
    end
    hold
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hold = 2
    self.each do |key, value|
      if key.is_a?(Symbol)
      hold += key.object_id.hash * value.hash
      else
      hold += key.hash / value.hash
      end
    end
    hold
  end
end
