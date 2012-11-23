require_relative './honorverse'

module Honorverse
  class Cruiser

    attr_reader :window, :x, :y, :image, :velocity_x, :velocity_y, :angle, :destroyed

    def initialize(window, image)
      @window = window
      @image = Gosu::Image.new(@window, image, false)
      @x = @y = @velocity_x = @velocity_y = @angle = 0.0
      @destroyed = false
    end

    def place( x, y )
      @x = x
      @y = y
    end

    def set_rotation( angle )
      @angle = angle
    end

    def turn_left
      @angle -= ANGLE_INCREMENT
    end

    def turn_right
      @angle += ANGLE_INCREMENT
    end

    def accelerate
      @velocity_x += Gosu::offset_x(angle, ACCEL_FACTOR)
      @velocity_y += Gosu::offset_y(angle, ACCEL_FACTOR)
    end

    def brake
      @velocity_x -= Gosu::offset_x(angle, BRAKE_FACTOR)
      @velocity_y -= Gosu::offset_y(angle, BRAKE_FACTOR)
    end

    def move
      @x += velocity_x
      @y += velocity_y
      @x %= WIDTH
      @y %= HEIGHT

      @velocity_x *= ENTROPY
      @velocity_y *= ENTROPY
    end

    def explode
      @destroyed = true
      @explosion_progress = 0
      @explosion_tiles = Gosu::Image.load_tiles(window, 'media/explosion.png', 35, 50, true)
    end

    def draw
      if destroyed
        if @explosion_progress < 17
          @explosion_tiles[@explosion_progress].draw_rot(x, y, 1, 0)
          @explosion_progress += 1
        end
      else
        image.draw_rot(x, y, 1, angle)
      end
    end
  end
end
