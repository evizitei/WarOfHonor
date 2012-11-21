require 'gosu'
require_relative './lib/fleet'

class GameWindow < Gosu::Window
  def initialize
    super Honorverse::WIDTH, Honorverse::HEIGHT, false
    self.caption = 'War of Honor'
    @background = Gosu::Image.new self, 'media/starfield.jpg', true
    reset_fleet
  end

  def update
    @player.execute_orders
    @enemy.execute_orders
  end

  def draw
    @player.draw
    @enemy.draw
    @background.draw 0, 0, 0
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

  def reset_fleet
    @player = Honorverse::Manticoran.new self
    @player.place 50, 50
    @player.set_rotation 90
    @enemy = Honorverse::Havenite.new self
    @enemy.place 850, 550
    @enemy.set_rotation 270
  end
end

window = GameWindow.new
window.show
