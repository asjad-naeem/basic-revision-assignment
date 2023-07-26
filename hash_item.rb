# This is Hash Item Class
class HashItem
  attr_accessor :key, :value, :next

  def initialize(key, val)
    @key = key
    @value = val
    @next = nil
  end
end
