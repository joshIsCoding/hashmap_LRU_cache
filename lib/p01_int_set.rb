class MaxIntSet
  attr_reader :max, :store
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num < max && num >= 0
  end

  def validate!(num)
    raise ArgumentError.new "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    num = num.to_int
    self[num] << num unless include?(num)
  end

  def remove(num)
    num = num.to_int
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    index = (num % num_buckets).abs
    @store[index]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return nil if include?(num)
    resize! if count == num_buckets - 1
    @count += 1
    self[num] << num
  end

  def remove(num)
    return nil unless include?(num)
    @count -=1 
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    index = (num % num_buckets).abs
    @store[index]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_bucket_num = num_buckets * 2
    new_store = Array.new(new_bucket_num) { Array.new }
    @store.each do |bucket|
      bucket.each do |value| 
        new_index = value % new_bucket_num
        new_store[new_index] << value
      end
    end
    @store = new_store
  end
end
