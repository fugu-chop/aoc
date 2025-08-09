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

    next if !all_criteria_met

    passport.each do |key, val|
      if !evaluate_compliance(key, val)
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
    
    passport.each do |entry|
      line = entry.strip().split(" ")
      line.each do |element|
        halves = element.split(":")
        claims[halves[0]] = halves[1]
      end
    end
  end

  all_passports << claims
end

def evaluate_compliance(key, val)
  val = val.strip()

  case key
  when "byr"
    return val.to_i >= 1920 && val.to_i <= 2002
  when "iyr"
    return val.to_i >= 2010 && val.to_i <= 2020
  when "eyr"   
    return val.to_i >= 2020 && val.to_i <= 2030
  when "hgt"
    return valid_hgt?(val)
  when "hcl"
    return val.match?(/#[a-f0-9]{6}/)
  when "ecl"
    return valid_ecl?(val)
  when "pid"
    return val.match?(/[0-9]{9}/) && val.length == 9
  when "cid"
    return true
  else
    return false
  end
end

def valid_hgt?(hgt)
  last_two_char = hgt[hgt.length()-2, hgt.length()-1]
  height = hgt[0, hgt.length()-2].to_i
  if last_two_char == "cm"
    return height >= 150 && height <= 193
  end

  if last_two_char == "in"
    return height >= 59 && height <= 76
  end

  return false
end

def valid_ecl?(ecl)
  valid_ecls = {
    "amb": true, 
    "blu": true,
    "brn": true,
    "gry": true,
    "grn": true,
    "hzl": true,
    "oth": true,
  }

  return valid_ecls.fetch(ecl.to_sym, nil)
end

execute("/Users/dean/Documents/aoc/2020/day04/input.txt")
