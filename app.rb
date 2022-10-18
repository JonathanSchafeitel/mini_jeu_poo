# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

player1 = 'josiane'
player2 = 'josé'

player1 = Players.new('josiane')
player2 = Players.new('josé')

puts "Voici l'état de chaque joueur :"
puts player1.show_state
puts player2.show_state
# while player1.life_points.positive? && player2.life_points.positive?
#   puts "Passons à la phase d'attaque :"
#   puts player1.attacks(player2)
#   if player2.life_points.negative?
#     break
#   else
#     puts player2.attacks(player1)
#   end
#
#   puts '-----------------------------------------------'
#   sleep(2)
# end
#
jo = HumanPlayer.new('jo')
binding.pry
