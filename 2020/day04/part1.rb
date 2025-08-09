CRITERION = {
  "byr": true,
  "iyr": true,
  "eyr": true,
  "hgt": true,
  "hcl": true,
  "ecl": true,
  "pid": true,
}

def execute(file_address)
  valid_passports = 0
  all_passports = get_passports(file_address)
  all_passports.each do |passport|
    all_criteria_met = true
    CRITERION.keys.each do |key|
      if !passport.fetch(key.to_s, nil)
        all_criteria_met = false
        break 
      end
    end
    valid_passports += 1 if all_criteria_met
  end

  puts valid_passports
end

def get_passports(file_address) 
  all_passports = []
  claims = {}

  File.foreach(file_address) do |result|
    passport = result.split("\n")
    if passport.size == 0
      all_passports << claims
      claims = {}
      next
    end
    
    # fish out keys only
    passport.each do |entry|
      line = entry.strip().split(" ")
      line.each do |element|
        claims[element.match(/[a-zA-Z]{3}/)[0]] = true
      end
    end
  end

  all_passports << claims
end

execute("/Users/dean/Documents/aoc/2020/day04/input.txt")
