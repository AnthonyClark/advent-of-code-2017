ADDRESS = 312051.freeze

def main
  puts "Part 1: total_steps: #{steps_from_address(ADDRESS)}"
end

def steps_from_address(address)
  ring_root = Math.sqrt(address).ceil
  steps_between_rings = ring_root / 2
  elements_in_ring = ring_root ** 2 - (ring_root-2) ** 2
  elements_per_side = elements_in_ring / 4
  position_in_ring = address - (ring_root - 2) ** 2
  position_in_side = position_in_ring % elements_per_side
  middle_of_side = elements_per_side / 2
  steps_on_ring = (position_in_side - middle_of_side).abs
  total_steps = steps_between_rings + steps_on_ring
end

main
