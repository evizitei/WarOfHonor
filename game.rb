require 'gosu'
require_relative './lib/fleet'

class GameWindow < Gosu::Window
  def initialize
    super Honorverse::WIDTH, Honorverse::HEIGHT, false
    self.caption = 'War of Honor'
    @scenario = Honorverse::Scenario.new self
  end

  def update
    @scenario.update
  end

  def draw
    @scenario.draw
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end

window = GameWindow.new
window.show
