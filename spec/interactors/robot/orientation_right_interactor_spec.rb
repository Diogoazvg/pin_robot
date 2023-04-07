# frozen_string_literal: true

require 'rails_helper'

describe Robot::OrientationRightInteractor, type: :interactor do
  subject { described_class.call(facing: facing) }

  describe '.call' do
    shared_examples 'rotate facing to corretly direction' do |direction|
      it { expect(subject.orientation).to eq direction }
    end

    context 'when facing north' do
      let(:facing) { :north }

      it_behaves_like 'rotate facing to corretly direction', :east
    end

    context 'when facing east' do
      let(:facing) { :east }

      it_behaves_like 'rotate facing to corretly direction', :south
    end

    context 'when facing south' do
      let(:facing) { :south }

      it_behaves_like 'rotate facing to corretly direction', :west
    end

    context 'when other value' do
      let(:facing) { :other }

      it_behaves_like 'rotate facing to corretly direction', :north
    end
  end
end
