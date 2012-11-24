require 'gosu'
require_relative '../../lib/scenario'

module Honorverse
  describe Scenario do

    let(:window) { stub }
    let(:image) { stub }
    let(:scenario) { Scenario.new window }
    let(:shipA) { stub("A", is_violated_by?: false) }
    let(:shipB) { stub("B", is_violated_by?: false) }

    before do
      Gosu::Image.stub(new: image)
    end

    describe '#check_for_collisions' do
      let(:shipC) { stub( "C" ) }

      before do
        scenario.clear
        scenario.add_ships shipA, shipB, shipC
      end

      it 'feeds every ship through the collision scenarios' do
        shipA.should_receive(:is_violated_by?).with(shipB).once
        shipA.should_receive(:is_violated_by?).with(shipC).once
        shipB.should_receive(:is_violated_by?).with(shipA).once
        shipB.should_receive(:is_violated_by?).with(shipC).once
        shipC.should_receive(:is_violated_by?).with(shipA).once
        shipC.should_receive(:is_violated_by?).with(shipB).once
        scenario.check_for_collisions
      end

      it 'explodes any that collide' do
        shipC.stub(:is_violated_by?).with(shipA).and_return true
        shipC.stub(:is_violated_by?).with(shipB).and_return false
        shipA.should_receive(:explode)
        shipB.should_not_receive(:explode)
        shipC.should_receive(:explode)
        scenario.check_for_collisions
      end
    end

    describe '#collision_between' do
      it 'returns true when ship A is crossed by ship B' do
        shipA.stub(is_violated_by?: true)
        scenario.collision_between?(shipA, shipB).should be_true
      end

      it 'returns true when ship B is crossed by ship A' do
        shipB.stub(is_violated_by?: true)
        scenario.collision_between?(shipA, shipB).should be_true
      end

      it 'returns false if there is no overlap from all parallels' do
        scenario.collision_between?(shipA, shipB).should be_false
      end
    end
  end
end
