TREE_CHAR = "#"
LINE_LEN = 31
INTERVALS = [
  [1,1],
  [3,1],
  [5,1], 
  [7,1],
  [1,2],
]

def execute(file_address)
  trees = []
  trees_in_run, position, idx = 0, 0, 0

  INTERVALS.each do |entry|
    File.foreach(file_address) do |result|
      if idx % entry[1] != 0
        idx += 1
        next
      end

      layer = result.to_s.strip()

      if layer[position] == TREE_CHAR
        trees_in_run += 1 
      end

      position = calculate_position(position, entry[0])

      idx += 1
    end

    trees << trees_in_run
    position, trees_in_run, idx = 0, 0, 0
  end

  puts trees.reduce(:*)
end

def calculate_position(position, steps)
  incremented_position = position + steps

  if incremented_position >= LINE_LEN
    incremented_position -= LINE_LEN
  end

  incremented_position
end

execute("/Users/dean/Documents/aoc/2020/day03/input.txt")
