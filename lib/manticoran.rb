require_relative './honorverse'
require_relative './cruiser'

module Honorverse
  class Manticoran < Cruiser

    def initialize(window)
      @game = window
      super window, 'media/cruiser.png'
      @width = 6
      @length = 42
    end

    def execute_orders
      turn_left if @game.button_down? Gosu::KbLeft
      turn_right if @game.button_down? Gosu::KbRight
      accelerate if @game.button_down? Gosu::KbUp
      brake if @game.button_down? Gosu::KbDown
      explode if @game.button_down? Gosu::KbE
      move
    end
  end

end
