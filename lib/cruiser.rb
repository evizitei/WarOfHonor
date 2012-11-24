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

    def set_dimensions( length, width )
      @length = length
      @width = width
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
        if DEBUG_COLLISIONS
          @point_image ||= Gosu::Image.new(@window, 'media/point.png', false)
          corner_points.each{|p| @point_image.draw( p[0], p[1], 2 ) }
        end
      end
    end

    def corner_points
      width_cosine = (@width / 2) * Math.cos(angle)
      width_sine = (@width / 2) * Math.sin(angle)
      length_cosine = (@length / 2) * Math.cos(angle)
      length_sine = (@length / 2) * Math.sin(angle)

      [
        [ (x + width_cosine - length_sine), (y + length_cosine + width_sine) ],
        [ (x - width_cosine - length_sine), (y + length_cosine - width_sine) ],
        [ (x + width_cosine + length_sine), (y - length_cosine + width_sine) ],
        [ (x - width_cosine + length_sine), (y - length_cosine - width_sine) ]
      ]
    end

    def is_violated_by?(ship)
      ship.corner_points.each do |ship_x, ship_y|
        delta_x = 0
        delta_y = 0
        self.corner_points.each do |my_x, my_y|
          delta_x += (ship_x > my_x) ? 1 : -1
          delta_y += (ship_y > my_y) ? 1 : -1
        end

        return true if delta_x.abs < 4 and delta_y.abs < 4
      end

      return false
    end
  end
end
