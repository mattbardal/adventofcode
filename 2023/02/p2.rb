# frozen_string_literal: true

input = defined?(DATA) ? DATA.read : File.read("../inputs/02.txt")

def parse_game_input(game)
  m_r, m_g, m_b = 0, 0, 0
  game_num, rounds = game.split(":")
  id = game_num.split(" ").last.to_i

  rounds.split(";").each do |round|
    passing = true
    round.split(",").each do |cubes|
      count, color = cubes.strip.split(" ")
      count = count.to_i

      case
      when color == "red" && count > m_r
        m_r = count
      when color == "green" && count > m_g
        m_g = count
      when color == "blue" && count > m_b
        m_b = count
      end
    end
  end
  return id, m_r * m_g * m_b
end

game_powers = []

input.each_line do |line|
  id, power = parse_game_input(line.delete("\n"))
  game_powers.append(power)
end

print game_powers.sum

__END__
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
