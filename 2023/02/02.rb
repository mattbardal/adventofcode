# frozen_string_literal: true

input = File.read("../inputs/02.txt")

R, G, B = 12, 13, 14

def parse_game_input(game)
  possible = true
  m_r, m_g, m_b = 0, 0, 0
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
        m_r = r if r > m_r
      when "green"
        g += count
        m_g = g if g > m_g
      when "blue"
        b += count
        m_b = b if b > m_b
      end
    end
    if r > R || g > G || b > B
      possible = false
    end
  end
  return (possible ? id : 0), m_r * m_g * m_b
end

possible_games = []
game_powers = []

input.each_line do |line|
  id, power = parse_game_input(line.delete("\n"))
  possible_games.append(id)
  game_powers.append(power)
end

puts possible_games.sum
puts game_powers.sum
