# frozen_string_literal: true

require 'rails_helper'

describe Robot::OrientationLeftInteractor, type: :interactor do
  subject { described_class.call(facing:) }

  describe '.call' do
    shared_examples 'rotate facing to corretly direction' do |direction|
      it { expect(subject.orientation).to eq direction }
    end

    context 'when facing north' do
      let(:facing) { :north }

      it_behaves_like 'rotate facing to corretly direction', :west
    end

    context 'when facing west' do
      let(:facing) { :west }

      it_behaves_like 'rotate facing to corretly direction', :south
    end

    context 'when facing south' do
      let(:facing) { :south }

      it_behaves_like 'rotate facing to corretly direction', :east
    end

    context 'when other value' do
      let(:facing) { :other }

      it_behaves_like 'rotate facing to corretly direction', :north
    end
  end
end
