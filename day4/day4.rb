require 'set'

def main 
  input = IO.read("day4_input.txt").split("\n")
  
  puts "Part 1 count: #{count_valid_phrases(input)}"
  puts "Part 2 count: #{count_valid_phrases(input, stop_palindromes: true)}"
end

def count_valid_phrases(phrases, stop_palindromes: false)
  phrases.inject(0) { |sum, phrase| valid_phrase?(phrase, stop_palindromes) ? sum + 1 : sum }
end

def valid_phrase?(phrase, stop_palindromes)
  s = Set.new
  phrase.split(" ").all? { |word| s.add?(stop_palindromes ? word.chars.sort.join : word) }
end

main
