# frozen_string_literal: true

require 'pry'

class Game
  attr_accessor :humain_player, :enemies_in_sight, :players_left

  # Il crée automatiquement 4 Player qu'il met dans @enemies et un HumanPlayer
  def initialize(name, nombre)
    @players_left = nombre
    @human_player = HumanPlayer.new(name)
    @enemies_in_sight = []
    5.times do |n|
      @enemies_in_sight << Players.new("Ennemi #{n}")
    end
    @players_left
  end

  # Cette méthode permet d'éliminer un adversaire tué.
  def kill_player(player)
    @enemies_in_sight.reject! { |k| k.name == player.name }
  end

  # Le jeu continue tant que le @human_player a encore des points de vie et qu'il reste des
  # Player à combattre dans l’array @enemies.
  def is_still_ongoing?
    return false if @human_player.life_points <= 0
    return false if @enemies_in_sight.select { |e| e.life_points.positive? }.size.zero? && @players_left.zero?

    true
  end

  # Une méthode qui montre l'état du joueur humain et le nombre de bot restant
  def show_players
    puts '-----------------------------------'
    puts "#{@human_player.name} a #{@human_player.life_points} points de vie et a une arme de niveau #{@human_player.weapon_level}"
    puts "Il reste encore #{enemies_in_sight.size} ennemis en vue #{@players_left}"
    puts '-----------------------------------'
  end

  # une méthode menu qui va afficher le menu de choix
  def menu
    puts '-----------------------------------'
    puts 'Que faire ?'
    puts 'a - Trouver une meilleure arme ?'
    puts 's - Trouver un pack santé ?'
    puts 'Attaquer un joueur en vue :'
    (0..enemies_in_sight.size - 1).each do |n|
      if @enemies_in_sight[n].life_points.positive?
        puts "#{n} - #{@enemies_in_sight[n].name} a #{@enemies_in_sight[n].life_points} points de vie"
      end
    end
    puts '-----------------------------------'
  end

  # Une méthode menu_choice qui prend en entrée un string.
  def menu_choice(str)
    case str
    when 'a'
      @human_player.search_weapon
    when 's'
      @human_player.search_health_pack
    else
      if str.to_i.between?(0, @enemies_in_sight.size - 1)
        @human_player.attacks(@enemies_in_sight[str.to_i])
        kill_player(@enemies_in_sight[str.to_i]) if @enemies_in_sight[str.to_i].life_points <= 0
      end
    end
  end

  # Écris une méthode enemies_attack qui va faire riposter tous les ennemis vivants.
  def enemies_attack
    puts "#{@human_player.name} est attaqué !!"
    @enemies_in_sight.each { |enemy| enemy.attacks(@human_player) if is_still_ongoing? }
  end

  def game_end
    puts 'The game is over'
    if @human_player.life_points.positive? && @enemies_in_sight.size.zero?
      puts 'Félicitation, tu as gagné !'
    else
      puts 'Tu as perdu, looser !'
    end
  end

  # Une méthode new_players_in_sight qui va avoir pour rôle de rajouter des ennemis en vue.
  def new_players_in_sight
    if @players_left == @enemies_in_sight.size
      puts 'Tous les ennemis sont déjà en vue'
    else
      nb_enemy = rand(1..6)
      if nb_enemy < 3
        puts "Aucun nouvel ennemi n'apparaît ce tour"
      elsif nb_enemy < 5
        puts 'Un nouvel ennemi apparaît !!'
        @enemies_in_sight << Players.new("Enemy #{enemies_in_sight.size}")
      else
        puts 'Deux nouveaux ennemis apparaissent'
        2.times do |n|
          @enemies_in_sight << Players.new("Enemy #{enemies_in_sight.size + n}")
        end
      end
    end
  end
end
