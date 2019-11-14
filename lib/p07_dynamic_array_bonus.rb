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
  include Enumerable

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return @store[i]
    rescue RuntimeError
    nil
  end

  def []=(i, val)
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.any? { |ele| val == ele }
  end

  def push(val)
    resize! if count == @store.length
    @store[count] = val
    self.count += 1
    nil
  end

  def unshift(val)
    resize! if count == @store.length
    prev = val
    i = 0
    while i <= count
      current = @store[i]
      @store[i] = prev
      prev = current
      i +=1
    end
    self.count += 1
    nil
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
    i = 0
    shifted_ele = @store[i]
    while i < count
      @store[i] = @store[i+1]
      i +=1
    end
    self.count -= 1
    shifted_ele
  end

  def first
    @store[0]
  end

  def last
    @store[count-1] if count > 0
  end

  def each(&block)
    count.times { |i| block.call(self[i]) }
    nil
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    self.each_with_index do |ele, i|
      return false if ele != other[i]
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(capacity * 2)
    capacity.times { |i| new_store[i] = @store[i] }
    @store = new_store

  end
end