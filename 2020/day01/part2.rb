# Part 2

TARGET = 2020
results = []

# Slurp file contents into array
File.foreach("/Users/dean/Documents/aoc/2020/day01/input.txt") do |result|
  results << result.to_i
end

results.each_with_index do |num1, idx1| 
  results.slice(idx1+1, results.length-1).each_with_index do |num2, idx2|
    if num1 + num2 >= TARGET
      next
    end

    results.slice(idx2+1, results.length-2).each_with_index do |num3, idx3|
      if num1 + num2 + num3 == TARGET 
        puts num1*num2*num3
      end
    end
  end
end