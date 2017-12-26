require 'set'

def main
  input = IO.read("day6_input.txt").split("\t").map(&:to_i)
  mem_bank = MemoryBank.new(input)

  puts "Part 1 count: #{mem_bank.rebalances_until_reptition}"
  puts "Part 2 count: #{mem_bank.rebalances_per_loop}"
end

class MemoryBank
  def initialize(blocks)
    @blocks = blocks
    @block_history = Set.new
  end

  def rebalances_until_reptition
    count = 0
    while @block_history.add?(serialize_blocks) do
      count += 1
      rebalance
    end
    count
  end

  def rebalances_per_loop
    mem_to_match = serialize_blocks
    count = 0
    while count += 1 do
      rebalance
      return count if mem_to_match == serialize_blocks
    end
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