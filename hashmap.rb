$LOAD_PATH << '.'

require 'hash_item'
# This is the hashmap class
class Hashmap
  def initialize
    @hash_items = []
    @hash_count = 50
  end

  def calculate_hash(key)
    key.hash % @hash_count
  end

  def push(key, val)
    index = calculate_hash(key)
    if @hash_items[index].nil?
      @hash_items[index] = HashItem.new(key, val)
    elsif @hash_items[index].key == key
      @hash_items[index].value = val
    else
      add_to_list(index)
    end
  end

  def add_to_list(index)
    head = @hash_items[index]
    head = head.next while head.next
    head.next = HashItem.new(key, val)
  end

  def get(key)
    index = calculate_hash(key)
    current = @hash_items[index]
    while current
      return current.value if current.key == key

      current = current.next
    end
  end

  def delete(key)
    index = calculate_hash(key)
    current = @hash_items[index]
    if current.nil?
      puts 'Invalid Entry! No data for the given key exists!'
    else
      prev = nil
      while current
        if current.key == key
          if prev.nil?
            @hash_items[index] = current.next
          else
            prev.next = current.next
          end
          return current.value
        end
        prev = current
        current = current.next
      end
    end
  end

  def print
    @hash_items.each do |list|
      next if list.nil?

      current = list
      while current
        if current.value.class == Hashmap
          puts '{'
          current.value.print
          puts '}'
        else
          puts "Key:#{current.key} Value:#{current.value}"
        end
        current = current.next
      end
    end
  end
end

hashmap = Hashmap.new
hashmap.push(1, 'a')
hashmap.push(2, 'b')
hashmap.push(3, 1)
hashmap.print             #Key: 1 Value: a  Key: 2 Value: b Key: 3 Value: 1
h = Hashmap.new
h.push(1,'asjad')
h.push(2,'adil')
hashmap.push(4, h)
hashmap.print             #Key: 3 Value: 1  Key: 2 Value: b  {Key:2 Value:adil    Key:1 Value:asjad}  Key: 1 Value: a
puts hashmap.get(1)       #a
hashmap.delete(1)
hashmap.print             #Key:2 Value:b  Key:3 Value:1 {Key:2 Value:adil   Key:1 Value:asjad}
