require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @numbers = []
  end

  def insert(key)
    num = key.hash
    unless include?(num)
      bucket(num) << key
      @count += 1
      @numbers << key
    end
    resize! if @count > num_buckets
  end

  def remove(key)
    num = key.hash
    bucket(num).delete(key)
  end

  def include?(key)
    num = key.hash
    bucket(num).include?(key)
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
    numbers.each do |key|
      insert(key)
    end
  end
  # def insert(key)
  #
  # end
  #
  # def include?(key)
  # end
  #
  # def remove(key)
  # end
  #
  # private
  #
  # def [](num)
  #   # optional but useful; return the bucket corresponding to `num`
  # end
  #
  # def num_buckets
  #   @store.length
  # end
  #
  # def resize!
  # end
end
