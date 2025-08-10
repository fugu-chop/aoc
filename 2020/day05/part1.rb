FRONT = "F"
BACK = "B"
RIGHT = "R"
LEFT = "L"

def execute(file_address)
  highest_id = 0
  File.foreach(file_address) do |result|    
    current_seat_id = get_seat_id(result)
    highest_id = current_seat_id if current_seat_id > highest_id
  end

  puts highest_id
end

def get_seat_id(reference)
  row = get_row(reference)
  col = get_column(reference)

  row * 8 + col
end

def get_column(reference)
  cols = [0,7]
  refs = reference[7,9].split("")

  refs[0,2].each do |ref|
    if ref == RIGHT
      cols = higher_half(cols)
    elsif ref == LEFT
      cols = lower_half(cols)
    end
  end

  if refs[2] == RIGHT
    return cols[1] 
  elsif refs[2] == LEFT
    return cols[0]
  end
end

def get_row(reference)
  seat_range = [0, 127]

  sequence = reference.split("")[0,7]

  sequence[0,5].each do |letter|
    if letter == FRONT
      seat_range = lower_half(seat_range)
    elsif letter == BACK
      seat_range = higher_half(seat_range)
    end
  end

  if sequence[6] == FRONT
    return seat_range[0]
  elsif sequence[6] == BACK
    return seat_range[1] 
  end
end

def higher_half(range)
  lower_limit = (range[0] + range[1] + 1) / 2
  [lower_limit, range[1]]
end

def lower_half(range)
  upper_limit = (range[0] + range[1] + 1) / 2 - 1
  [range[0], upper_limit]
end

execute("/Users/dean/Documents/aoc/2020/day05/input.txt")
