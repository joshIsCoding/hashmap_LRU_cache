class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
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
    index = num.hash % num_buckets
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
