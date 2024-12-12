input = defined?(DATA) ? DATA.read : File.read("../inputs/05.txt")

ordering_rules, updates = input.split("\n\n").map { |part| part.lines.map(&:chomp) }

ordering_rules_hash = Hash.new { |hash, key| hash[key] = [] }
ordering_rules.each do |rule|
  key, value = rule.split("|").map(&:to_i)
  ordering_rules_hash[key] << value
end

updates = updates.map { |update| update.split(",").map(&:to_i) }

invalid_orderings = updates.select do |update|
  update.each_cons(2).any? { |a, b| ordering_rules_hash[b].include?(a) }
end

invalid_orderings.each do |invalid_ordering|
  invalid_ordering.sort_by!.with_index do |value, index|
    ordering_rules_hash[value].count { |v| invalid_ordering.include?(v) }
  end
end

center_values = invalid_orderings.map { |ordering| ordering[ordering.length / 2] }.sum

puts center_values

__END__
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
