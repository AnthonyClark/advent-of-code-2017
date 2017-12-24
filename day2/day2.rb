def main 
  input = IO.read("day2_input.txt").split("\n").map{ |l| l.split(" ") }
  
  sum = 0
  input.each do |line|
    line = line.map(&:to_i)
    min = line.min
    max = line.max
    sum += max - min
  end

  puts sum
end

main
