def main 
  digits = IO.read("day1_input.txt").split("").map{ |i| i.to_i }

  puts "Captcha sum: #{sum_captcha(digits)}"
end

def sum_captcha(digits)
  sum = 0
  digits.take(digits.size - 1).each_with_index do |x, index|
    sum += x if x == digits[index+1]
  end
  sum += digits.first if digits.first == digits.last
end

main
