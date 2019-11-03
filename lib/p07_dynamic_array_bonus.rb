class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  attr_accessor :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    @store[i]
  end

  def []=(i, val)
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
  end

  def push(val)
    resize! if count == @store.length
    @store[count] = val
    self.count += 1
    nil
  end

  def unshift(val)
  end

  def pop
    if last
      last_ele = last 
      @store[count - 1] = nil
      self.count -= 1
      return last_ele
    end
    nil
  end

  def shift
  end

  def first
    @store[0]
  end

  def last
    @store[count-1] if count > 0
  end

  def each
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(capacity * 2)
    (0...capacity).times { |i| new_store[i] = @store[i] }
    @store = new_store

  end
end
