# frozen_string_literal: true

require 'rails_helper'

describe Robot::RemoveInvalidValuesInteractor, type: :interactor do
  subject { described_class.call(commands:) }

  let(:value_place1) { [rand(5..10), rand(5..10), :north] }
  let(:value_place2) { [rand(0..4), rand(0..4), :south] }
  let(:commands) { [{ place: value_place1 }, { move: true }, { place: value_place2 }, { left: true }] }

  describe '.call' do
    context 'when wrong place' do
      it 'remove place and then command until a valid place' do
        expect(subject.clear_commands).to contain_exactly({ place: value_place2 }, { left: true })
      end
    end

    context 'when valid places' do
      let(:value_place1) { [rand(0..4), rand(0..4), :east] }

      it { expect(subject.clear_commands).to match_array(commands) }
    end
  end
end
