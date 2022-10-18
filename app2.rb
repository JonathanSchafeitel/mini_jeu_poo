# frozen_string_literal: true

require 'colorize'
require 'colorized_string'
require 'pry'
require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def perform
  system 'clear'
  puts "
  \\\||||||////
  \\  ~ ~  //
   (  @ @  )
______ oOOo-(_)-oOOo___________
.......
....... Bienvenue, Moussailon !
.......
_____________Oooo._____________
.oooO     (   )
(   )     ) /
\ (     (_/
\_)"
  # setup : creation of the Human Player
  puts 'Entre le nom de ton personnage :'
  print '> '

  player1 = HumanPlayer.new(gets.chomp)

  # setup : creation of the enemies array
  enemies = []
  enemies << Players.new('José')
  enemies << Players.new('Josianne')

  until game_over?(player1, enemies)
    system 'clear'
    player1.show_state

    # print du battle menu
    puts '------------------------------------------'
    puts ''
    puts 'Que veut tu faire ?'
    puts 'a - Trouvé une meilleure arme ?'
    puts 's - Trouver un pack santé ?'
    puts ''
    puts '------------------------------------------'
    puts 'Attaquer un joueur en vue :'
    puts ''
    (0..enemies.size - 1).each do |n|
      if enemies[n].life_points.positive?
        puts "#{n} - #{enemies[n].name.colorize(:red)} a #{enemies[n].life_points} points de vie"
      end
    end
    puts '------------------------------------------'
    user_input = '45'

    while (user_input != 'a') && (user_input != 's') && !user_input.to_i.between?(0, enemies.size - 1)
      puts 'Sélectionne une action à effectuer'
      print '> '
      user_input = gets.chomp
      puts '------------------------------------------'
    end

    case user_input
    when 'a'
      player1.search_weapon
    when 's'
      player1.search_health_pack
    else
      player1.attacks(enemies[user_input.to_i]) if user_input.to_i.between?(0, enemies.size - 1)
    end

    # enemies turn
    puts "#{player1.name} est attaqué !!"
    enemies.each { |enemy| enemy.attacks(player1) if enemy.life_points.positive? }
    puts '>> Fin du tour, appuye sur Entrée pour continuer <<'
    gets

  end

  player1.life_points.positive? ? (puts 'Félicitations, tu as gagné !!!').on_blue : (puts 'Tu as été vaincu au combat, quel lâche !')
end

# boolean check if the game is over
def game_over?(player1, enemies)
  return true if player1.life_points <= 0
  return true if enemies.select { |enemy| enemy.life_points.positive? }.size.zero?

  false
end
perform
binding.pry
