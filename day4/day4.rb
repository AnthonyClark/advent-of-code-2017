require 'set'

def main 
  input = IO.read("day4_input.txt").split("\n")
  
  puts "Part 1 count: #{count_valid_phrases(input)}"
  puts "Part 2 count: #{count_valid_phrases(input, stop_palindromes: true)}"
end

def count_valid_phrases(phrases, stop_palindromes: false)
  phrases.inject(0) do |sum, phrase|
    valid_phrase?(phrase, stop_palindromes) ? sum + 1 : sum
  end
end

def valid_phrase?(phrase, stop_palindromes)
  s = Set.new
  phrase.split(" ").each do |word|
    return false unless s.add?(stop_palindromes ? word.chars.sort.join : word)
  end
  true
end

main
