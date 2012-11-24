require_relative 'honorverse'
require_relative 'manticoran'
require_relative 'havenite'

module Honorverse
  class Scenario
    def initialize(window)
      @ships = []
      @window = window
      @background = Gosu::Image.new @window, 'media/starfield.jpg', true
      add_ship(Honorverse::Manticoran, 50, 50, 90)
      add_ship(Honorverse::Havenite, 850, 550, 270)
    end

    def add_ship(ship_type, x, y, rotation)
      ship = ship_type.new @window
      ship.place x, y
      ship.set_rotation rotation
      @ships << ship
    end

    def add_ships(*ships)
      @ships += ships
    end

    def update
      @ships.each { |ship| ship.execute_orders }
      check_for_collisions
    end

    def clear
      @ships = []
    end

    def draw
      @ships.each { |ship| ship.draw }
      @background.draw 0, 0, 0
    end

    def check_for_collisions
      @ships.select{|s| !s.destroyed }.combination(2).each do |ship1, ship2| 
        if collision_between?( ship1, ship2 )
          ship1.explode
          ship2.explode
        end
      end
    end

    def collision_between?(ship_one, ship_two)
      ship_one.is_violated_by?(ship_two) || ship_two.is_violated_by?(ship_one)
    end
  end
end
