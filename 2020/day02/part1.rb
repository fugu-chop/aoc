def execute(file_address) 
  compliant = 0

  File.foreach(file_address) do |result|
    ruleset = result.split(":")
    rule_memo = memoise_rule(ruleset[0])
    password_memo = memoise_password(ruleset[1])

    rule_memo.each do |key, value|
      counts = password_memo.fetch(key, nil)

      next if !counts
        
      compliant += 1 if counts >= value[0] && counts <= value[1]
    end
  end

  puts compliant
end

def memoise_rule(rule)
  ruleset = rule.split(" ")
  counts = ruleset[0].split("-").map { |count| count.to_i}
  letter = ruleset[1]

  return {
    letter => counts
  }
end

def memoise_password(password)
  memo = {}
  string_pw = password.strip().split("")

  string_pw.each do |letter|
    if memo[letter] 
      memo[letter]+= 1
    else 
      memo[letter] = 1
    end
    
  end

  return memo
end

execute("/Users/dean/Documents/aoc/2020/day02/input.txt")
