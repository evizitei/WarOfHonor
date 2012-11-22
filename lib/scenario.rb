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

    def update
      @ships.each { |ship| ship.execute_orders }
    end

    def draw
      @ships.each { |ship| ship.draw }
      @background.draw 0, 0, 0
    end
  end
end
