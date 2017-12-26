def main
  input = IO.read("day5_input.txt").split("\n").map(&:to_i)

  puts "Part 1 count: #{count_jumps(input.dup)}"
  puts "Part 2 count: #{count_jumps(input, part2: true)}"
end

def count_jumps(input, part2: false)
  pc, jumps = 0, 0

  while(pc < input.size ) do
    next_pc = pc + input[pc]
    jumps += 1
    if part2 && input[pc] >= 3 then
      input[pc] -= 1
    else
      input[pc] += 1
    end
    pc = next_pc
  end

  jumps
end

main
