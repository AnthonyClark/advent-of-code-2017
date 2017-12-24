def main 
  input = IO.read("day2_input.txt").split("\n").map{ |l| l.split(" ") }
  
  part_one(input)
  part_two(input)

end

def part_one(input)
  sum = input.inject(0) { |sum, line| sum + min_max_diff(line.map(&:to_i)) }
  puts "Part 1: #{sum}"
end

def part_two(input)
  sum = input.inject(0) { |sum, line| sum + divisor_sum(line.map(&:to_i).sort) }
  puts "Part 2: #{sum}"
end

def min_max_diff(line)
  line.max - line.min
end

def divisor_sum(line)
  line.each do |x|
    line.each do |y|
      break if y >= x
      return x/y if x % y == 0
    end
  end
end

main
