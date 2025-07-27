# Part 1

TARGET = 2020
results_hash = {}

# Slurp file contents into hash
File.foreach("/Users/dean/Documents/aoc/2020/day01/input.txt") do |result|
    results_hash[result.to_i] = result.to_i
end

results_hash.each do |key, _| 
    other_pair = results_hash.fetch(TARGET - key, nil)
    if other_pair
        puts key * other_pair
    end
end
