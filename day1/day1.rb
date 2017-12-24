def main 
  digits = IO.read("day1_input.txt").split("").map{ |i| i.to_i }

  puts "Part 1 Captcha sum: #{sum_captcha(digits, 1)}"
  puts "Part 2 Captcha sum: #{sum_captcha(digits, digits.size/2)}"
end

def sum_captcha(digits, offset)
  digits.each_with_index.inject(0) do |sum, (d, index)|
    next_i = (index + offset) % (digits.length)
    d == digits[next_i] ? sum + d : sum
  end
end

main
