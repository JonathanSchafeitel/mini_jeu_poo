# frozen_string_literal: true

require 'English'
require 'pry'
require 'colorize'
require 'colorized_string'

class Players
  attr_accessor :name, :life_points

  # Init du constructor
  def initialize(name)
    @name = name
    @life_points = 10
  end

  # Affiche les point de vie du joueur
  def show_state
    puts "Le joueur #{@name} a #{@life_points} points de vie"
  end

  # Applique le domage au joueur
  def gets_damage(amount)
    @life_points -= amount
    puts "Le joueur #{@name} a été tué".colorize(:red).on_blue.underline if @life_points < 1
  end

  # Lance une attaque
  def attacks(players2)
    puts "#{name} attaque #{players2.name} !"
    dmg = roll_damage
    puts "Il y a eu #{dmg} points de dégats"
    players2.gets_damage(dmg)
  end

  # Fonction qui roll un nombre aléatoire de domage
  def roll_damage
    rand(1..6)
  end
end

class HumanPlayer < Players
  attr_accessor :weapon_level

  def initialize(name)
    super(name) # appel au constructeur de la classe Player
    @life_points = 100
    @weapon_level = 1
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
  end

  def roll_damage
    rand(1..6) * @weapon_level
  end

  # Nouvelle arme
  def search_weapon
    number_rand = rand(1..6)
    puts "Bravo tu as trouvé une arme de niveau #{number_rand} !"
    if number_rand > @weapon_level then @weapon_level = number_rand
                                        puts "Ouais! Cette arme est meilleure que ton arme actuelle : tu l'équipe de suite !".colorize(:green)

    else
      puts 'Ton arme actuelle est plus puissante :( dommage'.colorize(:red)
      puts '------------------------------------------'
    end
  end

  # Pack point de vie
  def search_health_pack
    number_rand = rand(1..6)
    puts "A la reccherche d'un pack de soin ".colorize(:green)
    sleep(2)
    if number_rand == 1
      puts "Tu n'a rien trouvé...".colorize(:red)
    elsif number_rand < 6
      puts 'Bravo, tu as trouvé un pack de +50 points de vie !'.colorize(:green)
      @life_points = life_points + 50
      @life_points = 100 if life_points > 100
    else
      number_rand == 6
      puts 'Waow, tu as trouvé un pack de +80 points de vie !'.colorize(:green)
      @life_points = life_points + 80
      @life_points = 100 if life_points > 100
    end
    puts "Nombre de point de vie actuel : #{@life_points}".colorize(:green)
  end
end
