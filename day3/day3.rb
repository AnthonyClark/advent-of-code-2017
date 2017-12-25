ADDRESS = 312051.freeze

def main
  puts "Part 1: total_steps: #{steps_from_address(ADDRESS)}"
  puts "Part 2: value: #{part_two}"
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

def part_two
  sides = []
  sides[0] = [[1],[1],[1],[1]]
  sides[1] = [[1,2],[4,5],[10,11],[23,25]]

  numbers_per_side = 2
  side_of_ring = 3
  last_number = 25

  (2..100).to_a.each do |ring|
    numbers_per_side += 2
    (0..3).to_a.each do |side_of_ring|
      (0..numbers_per_side - 1).to_a.each do |position_on_side|
        sum = last_number # They all add to the most recent number

        # if starting new ring
        if side_of_ring == 0 && position_on_side == 0
          sum += sides[ring-1][side_of_ring][0]

          sides << [[sum]]

        # starting new side
        elsif position_on_side == 0
          sum += sides[ring][side_of_ring - 1][-2]
          sum += sides[ring - 1][side_of_ring - 1][-1]
          sum += sides[ring - 1][side_of_ring][0]

          sides[ring] << [sum]

        # second on side
        elsif position_on_side == 1
          sum += sides[ring-1][side_of_ring-1].last
          sum += sides[ring-1][side_of_ring][0]
          sum += sides[ring-1][side_of_ring][1]
          sides[ring][side_of_ring] << sum

        # last two on side
        elsif position_on_side >= numbers_per_side - 2
          sum += sides[ring - 1][side_of_ring][-1]
          sum += sides[ring - 1][side_of_ring][-2] if position_on_side == numbers_per_side - 2 # only for second last
          sum += sides[ring][0][0] if side_of_ring == 3 # only for closing the ring

          sides[ring][side_of_ring] << sum

        # middle areas of a side
        else
          sum += sides[ring - 1][side_of_ring][position_on_side - 2]
          sum += sides[ring - 1][side_of_ring][position_on_side - 1]
          sum += sides[ring - 1][side_of_ring][position_on_side]

          sides[ring][side_of_ring] << sum
        end

        last_number = sum

        if last_number > ADDRESS
          return last_number
        end
      end
    end
  end
end

main
