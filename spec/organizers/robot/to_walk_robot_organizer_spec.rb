# frozen_string_literal: true

require 'rails_helper'

describe Robot::ToWalkRobotOrganizer, type: :interactor do
  describe '.organized' do
    context 'when call organized' do
      let(:organizers) do
        [
          Robot::ParseValuesInteractor,
          Robot::RemoveInvalidValuesInteractor,
          Robot::WalkRobotInteractor
        ]
      end

      it 'returns iteractors' do
        expect(described_class.organized).to eq organizers
      end
    end
  end
end
