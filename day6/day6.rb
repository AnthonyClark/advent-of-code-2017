require 'set'

def main
  input = IO.read("day6_input.txt").split("\t").map(&:to_i)

  puts "Part 1 count: #{MemoryBank.new(input).rebalance_cycles}"
end

class MemoryBank
  def initialize(blocks)
    @blocks = blocks
    @block_history = Set.new
  end

  def rebalance_cycles
    count = 0
    while @block_history.add?(serialize_blocks) do
      count += 1
      rebalance
    end
    count
  end

  private

  def rebalance
    index = max_index
    max_val = @blocks[index]
    @blocks[index] = 0
    (1..max_val).each { |offset| @blocks[(index + offset) % @blocks.size] += 1 }
  end

  def serialize_blocks
    @blocks.map(&:to_s).join(':')
  end

  def max_index
    @blocks.each_with_index.inject(0) { |index, (val, i)|  val > @blocks[index] ? i : index }   
  end
end


main