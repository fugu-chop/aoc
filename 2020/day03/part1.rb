TREE_CHAR = "#"
LINE_LEN = 31
STEPS = 3

def execute(file_address)
  trees = 0
  position = 0

  File.foreach(file_address) do |result|
    layer = result.to_s.strip()
    if layer[position] == TREE_CHAR
      trees += 1 
    end

    position = calculate_position(position)
  end

  puts trees
end

def calculate_position(position)
  incremented_position = position + STEPS

  if incremented_position < LINE_LEN 
    return incremented_position
  else
    return incremented_position - LINE_LEN
  end
end

execute("/Users/dean/Documents/aoc/2020/day03/input.txt")