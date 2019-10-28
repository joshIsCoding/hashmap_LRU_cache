require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    target_bucket = bucket(key)
    if target_bucket.include?(key)
      target_bucket.update(key, val)
    else
      target_bucket.append(key, val)
      self.count +=1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
  end

  def each
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!

  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    index = key.hash % num_buckets
    @store[index]
  end
end
