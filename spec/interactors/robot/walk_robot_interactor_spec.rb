# frozen_string_literal: true

require 'rails_helper'

describe Robot::WalkRobotInteractor, type: :interactor do
  subject { described_class.call(clear_commands:) }

  let(:clear_commands) { [move] }
  let(:place) { { place: [1, 2, :south] } }
  let(:move) { { move: true } }

  shared_examples 'move to' do |move_place|
    it { expect(subject.place).to eq move_place }
  end

  describe 'move' do
    context 'when move without place' do
      it_behaves_like 'move to', { x: 0, y: 1, f: :north }
    end

    context 'when move with invalid place and use default place' do
      let(:clear_commands) { [place, move] }
      let(:place) { { invalid: [1, 2, :north] } }

      it_behaves_like 'move to', { x: 0, y: 1, f: :north }
    end
  end

  describe 'place' do
    context 'when only place' do
      let(:clear_commands) { [place] }

      it { expect(subject.place).to include(x: place[:place][0], y: place[:place][1], f: place[:place][2]) }
      it { expect(subject.facing).to eq place[:place][2] }
    end
  end

  describe 'rotate left initial facing north' do
    let(:left) { { left: true } }
    let(:clear_commands) { [left] }

    shared_examples 'change facing' do |face|
      it { expect(subject.facing).to eq face }
    end

    context 'when one left' do
      it_behaves_like 'change facing', :west
    end

    context 'when two lefts' do
      let(:clear_commands) { [left, left] }
      it_behaves_like 'change facing', :south
    end

    context 'when three lefts' do
      let(:clear_commands) { [left, left, left] }
      it_behaves_like 'change facing', :east
    end

    context 'when four lefts' do
      let(:clear_commands) { [left, left, left, left] }
      it_behaves_like 'change facing', :north
    end
  end

  describe 'rotate right initial facing north' do
    let(:right) { { right: true } }
    let(:clear_commands) { [right] }

    shared_examples 'change facing' do |face|
      it { expect(subject.facing).to eq face }
    end

    context 'when one right' do
      it_behaves_like 'change facing', :east
    end

    context 'when two rights' do
      let(:clear_commands) { [right, right] }
      it_behaves_like 'change facing', :south
    end

    context 'when three rights' do
      let(:clear_commands) { [right, right, right] }
      it_behaves_like 'change facing', :west
    end

    context 'when four rights' do
      let(:clear_commands) { [right, right, right, right] }
      it_behaves_like 'change facing', :north
    end
  end

  describe 'report' do
    let(:clear_commands) { [report] }
    let(:report) { { report: true } }
    context 'when the one report' do
      it 'returns two objects reports, default and passed' do
        expect(subject.reports.length).to eq 2
      end
    end

    context 'when the report more the one' do
      let(:quantity) { rand(100) }
      let(:clear_commands) do
        commands = []
        quantity.times { commands << report }
        commands
      end

      it 'returns number of reports + 1(default)' do
        expect(subject.reports.length).to eq quantity + 1
      end
    end
  end
end
