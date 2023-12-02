# frozen_string_literal: true

input = File.read("../inputs/02.txt")

R, G, B = 12, 13, 14

def parse_game_input(game)
  possible = true
  m_r, m_g, m_b = 0, 0, 0
  game_num, rounds = game.split(": ")
  id = game_num.split.last.to_i

  rounds.split("; ").each do |round|
    r, g, b = 0, 0, 0
    round.split(", ").each do |cubes|
      count, color = cubes.split
      count = count.to_i

      case color.downcase
      when "red"
        r += count
        m_r = [r, m_r].max
      when "green"
        g += count
        m_g = [g, m_g].max
      when "blue"
        b += count
        m_b = [b, m_b].max
      end
    end
    possible = false if r > R || g > G || b > B
  end
  [possible ? id : 0, m_r * m_g * m_b]
end

possible_games = []
game_powers = []

possible_games, game_powers = input.each_line.map do |line|
  parse_game_input(line.chomp)
end.transpose

puts possible_games.sum
puts game_powers.sum
