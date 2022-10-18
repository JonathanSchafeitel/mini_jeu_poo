# frozen_string_literal: true

require 'pry'
require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def perform
  my_game = Game.new(init, 100)
  game_loop(my_game) while my_game.is_still_ongoing?
  my_game.game_end
end

def game_loop(my_game)
  system 'clear'
  my_game.show_players
  my_game.menu
  user_input = -1
  until user_check(user_input, my_game.enemies_in_sight.size)
    puts 'Veuillez sélectionner une action à effectuer'
    print '> '
    user_input = gets.chomp
  end
  my_game.menu_choice(user_input)
  my_game.enemies_attack
  my_game.new_players_in_sight
  my_game.show_players
  gets
end

def init
  system 'clear'
  puts 'Veuillez nommer votre joueur :'
  puts '> '
  gets.chomp
end

def user_check(str, nb_enemy)
  case str
  when 'a'
    return true
  when 's'
    return true
  else
    nb_enemy.times do |n|
      return true if str == n.to_s
    end

  end

  false
end
perform
