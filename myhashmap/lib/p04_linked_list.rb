class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next
    @next.prev = @prev
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
    # @store = [@head,@tail]
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    return true if first == @tail
    false
  end

  def get(key)
    location = @head
    until location.key == key || location == @tail
      location = location.next
    end
    return location.val
  end

  def include?(key)
    location = @head
    until location.key == key || location == @tail
      location = location.next
    end
    location != @tail
  end

  def append(key, val)
    var = Node.new(key, val)
    var.prev = @tail.prev
    @tail.prev.next = var
    var.next = @tail
    @tail.prev = var
  end

  def update(key, val)
    location = @head
    until location.key == key || location == @tail
      location = location.next
    end
    location.val = val if location != @tail
  end

  def remove(key)
    location = @head
    until location.key == key || location == @tail
      location = location.next
    end
    location.remove if location != @tail
  end
end

module Enumerable
  def each(&prc)
    location = @head.next
    until location == @tail
      prc.call(location)
      location = location.next
    end

  end
end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
