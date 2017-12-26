def main
  input = IO.read("day5_input.txt").split("\n").map(&:to_i)

  puts "Part 1 count: #{count_jumps(input)}"
end

def count_jumps(input)
  pc = 0
  jumps = 0

  while(pc < input.size ) do
    next_pc = pc + input[pc]
    jumps += 1
    input[pc] += 1
    pc = next_pc
  end

  jumps
end

main
