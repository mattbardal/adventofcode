# frozen_string_literal: true

input = defined?(DATA) ? DATA.read : File.read("../inputs/02.txt")

R, G, B = 12, 13, 14

def parse_game_input(game)
  possible = true
  game_num, rounds = game.split(":")
  id = game_num.split(" ").last.to_i

  rounds.split(";").each do |round|
    r, g, b = 0, 0, 0
    round.split(",").each do |cubes|
      count, color = cubes.strip.split(" ")
      count = count.to_i

      case color.downcase
      when "red"
        r += count
      when "green"
        g += count
      when "blue"
        b += count
      end
    end
    if r > R || g > G || b > B
      possible = false
    end
  end
  return id if possible
end

possible_games = []

input.each_line do |line|
  id = parse_game_input(line.delete("\n"))
  possible_games.append(id) unless id.nil?
end

print possible_games.sum

__END__
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
