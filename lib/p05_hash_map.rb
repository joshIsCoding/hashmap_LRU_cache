require_relative 'p04_linked_list'

class HashMap
  include Enumerable
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
      resize! if self.count == num_buckets - 1
      target_bucket.append(key, val)
      self.count +=1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    target_bucket = bucket(key)
    if target_bucket.include?(key)
      target_bucket.remove(key)
      self.count -= 1
    end
  end

  def each(&each_block)
    @store.each do |bucket|
      bucket.each { |node| each_block.call(node.key, node.val) }
    end

  end

  # uncomment when you have Enumerable included
  def to_s
     pairs = inject([]) do |strs, (k, v)|
       strs << "#{k.to_s} => #{v.to_s}"
     end
     "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!

    new_num_buckets = num_buckets * 2
    new_store = Array.new(new_num_buckets) { LinkedList.new }
    self.each do |k, v| 
      new_store[k.hash % new_num_buckets].append(k, v)
    end
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    index = key.hash % num_buckets
    @store[index]
  end
end
