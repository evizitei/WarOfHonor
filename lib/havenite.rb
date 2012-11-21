require_relative './honorverse'

module Honorverse
  class Havenite < Cruiser
    def initialize(window)
      super window, 'media/havenite.png'
      @manuever_in_progress = nil
    end

    MANUEVERS = [:hard_right, :full_accel, :slight_left, :kill_velocity]

    def execute_orders
      if @manuever_in_progress.nil?
        @manuever_in_progress = MANUEVERS.sample
      end
      send @manuever_in_progress
      move
    end

    def manuever(motion, target_sum)
      @manuever_sum = 0 unless @manuever_sum
      send motion
      @manuever_sum += 1
      if @manuever_sum >= target_sum
        @manuever_in_progress = nil
        @manuever_sum = nil
      end
    end

    def hard_right
      manuever :turn_right, 80
    end

    def slight_left
      manuever :turn_left, 40
    end

    def full_accel
      manuever :accelerate, 800
    end

    def kill_velocity
      manuever :brake, 400
    end

  end
end
