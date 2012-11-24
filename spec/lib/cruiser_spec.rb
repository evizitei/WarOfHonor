require 'gosu'
require_relative '../../lib/cruiser'

module Honorverse
  describe Cruiser do

    let(:window) { stub }
    let(:image) { stub }
    let(:cruiser) { Cruiser.new window, 'media/stub.png' }
    before { Gosu::Image.stub(:new) { image } }

    subject { cruiser }

    describe '#initialize' do
      its(:window) { should == window }
      its(:image) { should == image }
      its(:x) { should == 0 }
      its(:y) { should == 0 }
      its(:velocity_x) { should == 0.0 }
      its(:velocity_y) { should == 0.0 }
      its(:angle) { should == 0.0 }
      its(:destroyed) { should be_false }
    end

    describe '#place' do
      before { cruiser.place 30, 50 }

      its(:x) { should == 30 }
      its(:y) { should == 50 }
    end

    describe '#set_rotation' do
      before { cruiser.set_rotation 90 }
      its(:angle) { should == 90 }
    end


    describe '#move' do
      it 'accelerates by the current velocity' do
        cruiser.instance_variable_set(:@velocity_x, 10)
        cruiser.instance_variable_set(:@velocity_y, 12)
        cruiser.move
        cruiser.x.should == 10
        cruiser.y.should == 12
      end

      it 'wraps the screen position by the window dimensions' do
        cruiser.instance_variable_set(:@x, WIDTH + 42)
        cruiser.instance_variable_set(:@y, HEIGHT + 42)
        cruiser.move
        cruiser.x.should == 42
        cruiser.y.should == 42
      end

      it 'degrades the velocity according to the entropy constant' do
        cruiser.instance_variable_set(:@velocity_x, 100)
        cruiser.instance_variable_set(:@velocity_y, 1000)
        cruiser.move
        cruiser.velocity_x.should == 99.9
        cruiser.velocity_y.should == 999.0
      end
    end

    describe '#is_violated_by' do
    end

  end
end
