def execute(file_address)
  counter = 0

  File.foreach(file_address) do |result|
    ruleset = result.split(":")
    rule = ruleset[0]
    password = ruleset[1]

    counter += 1 if check_password(rule, password)
  end

  puts counter
end

def check_password(rule, password)
  conditions = rule.split(" ")
  password_arr = password.strip().split("")
  letter = conditions[1].strip()
  
  first_idx, second_idx = conditions[0].split("-")
  first_idx = first_idx.to_i - 1
  second_idx = second_idx.to_i - 1

  return password_arr[first_idx] == letter && password_arr[second_idx] != letter || 
  password_arr[first_idx] != letter && password_arr[second_idx] == letter
end

execute("/Users/dean/Documents/aoc/2020/day02/input.txt")
