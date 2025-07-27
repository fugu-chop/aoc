# Part 2

TARGET = 2020
results_hash = {}

# Slurp file contents into hash
File.foreach("/Users/dean/Documents/aoc/2020/day01/input.txt") do |result|
    results_hash[result.to_i] = result.to_i
end

