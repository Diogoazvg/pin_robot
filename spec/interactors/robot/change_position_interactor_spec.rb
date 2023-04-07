# frozen_string_literal: true

require 'rails_helper'

describe Robot::ChangePositionInteractor, type: :interactor do
  subject { described_class.call(facing:, place:) }

  let(:place) { { x: x_value, y: y_value, f: :facing } }
  let(:x_value) { 0 }
  let(:y_value) { 0 }
  let(:facing) { :west }

  shared_examples 'must not move' do |operator, current_position|
    it 'must not move' do
      expect(subject.place[operator]).to eq current_position
    end
  end

  describe '.call' do
    context 'when x facing west in 0' do
      it_behaves_like 'must not move', :x, 0
    end

    context 'when x facing east in 4' do
      let(:x_value) { 4 }
      let(:facing) { :east }

      it_behaves_like 'must not move', :x, 4
    end

    context 'when y facing south in 0' do
      let(:facing) { :south }

      it_behaves_like 'must not move', :y, 0
    end

    context 'when y facing south in 4' do
      let(:y_value) { 4 }
      let(:facing) { :north }

      it_behaves_like 'must not move', :y, 4
    end

    context 'when x facing west > 0' do
      let(:x_value) { rand(1..4) }

      it 'must move' do
        expect(subject.place[:x]).to eq(x_value - 1)
      end
    end

    context 'when x facing east < 4' do
      let(:x_value) { rand(0..3) }
      let(:facing) { :east }

      it 'must move' do
        expect(subject.place[:x]).to eq(x_value + 1)
      end
    end

    context 'when y facing south > 0' do
      let(:facing) { :south }
      let(:y_value) { rand(1..4) }

      it 'must move' do
        expect(subject.place[:y]).to eq(y_value - 1)
      end
    end

    context 'when y facing south < 4' do
      let(:y_value) { rand(0..3) }
      let(:facing) { :north }

      it 'must move' do
        expect(subject.place[:y]).to eq(y_value + 1)
      end
    end
  end
end
