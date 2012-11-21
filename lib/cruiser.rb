require_relative './honorverse'

module Honorverse
  class Cruiser
    def initialize(window, image)
      @image = Gosu::Image.new(window, image, false)
      @x = @y = @velocity_x = @velocity_y = @angle = 0.0
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
      @velocity_x += Gosu::offset_x(@angle, ACCEL_FACTOR)
      @velocity_y += Gosu::offset_y(@angle, ACCEL_FACTOR)
    end

    def brake
      @velocity_x -= Gosu::offset_x(@angle, BRAKE_FACTOR)
      @velocity_y -= Gosu::offset_y(@angle, BRAKE_FACTOR)
    end

    def move
      @x += @velocity_x
      @y += @velocity_y
      @x %= WIDTH
      @y %= HEIGHT

      @velocity_x *= ENTROPY
      @velocity_y *= ENTROPY
    end

    def draw
      @image.draw_rot(@x, @y, 1, @angle)
    end
  end
end
