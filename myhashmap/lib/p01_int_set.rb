class MaxIntSet
  def initialize(max)
    @store = Array.new(max) { false }
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
    (0..@store.length).to_a.include?(num)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    unless include?(num)
      bucket(num) << num
    end
  end

  def remove(num)
    bucket(num).delete(num)
  end

  def include?(num)
    bucket(num).include?(num)
  end

  private

  def bucket(num)
    bucket_number = num % num_buckets
    @store[bucket_number]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @numbers = []
  end

  def insert(num)
    unless include?(num)
      bucket(num) << num
      @count += 1
      @numbers << num
    end
    resize! if @count > num_buckets
  end

  def remove(num)
    bucket(num).delete(num)
  end

  def include?(num)
    bucket(num).include?(num)
  end

  private

  def bucket(num)
    bucket_number = num % num_buckets
    @store[bucket_number]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    numbers = @numbers.dup
    @numbers = []
    numbers.each do |num|
      insert(num)
    end
  end
end
