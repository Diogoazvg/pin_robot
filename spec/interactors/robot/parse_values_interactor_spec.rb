# frozen_string_literal: true

require 'rails_helper'

describe Robot::ParseValuesInteractor, type: :interactor do
  subject { described_class.call(values: params) }

  let(:params) { 'PLACE:0,1,NORTH NOT_MOVE MOVE LEFT RIGHT JHON_DOE REPORT 1 3 PLACE:0,2,SOUTH' }
  let(:valid_parms) do
    [{ place: [0, 1, :north] }, { move: true }, { left: true }, { right: true }, { report: true },
     { place: [0, 2, :south] }]
  end

  shared_examples 'return valid params' do
    it 'return parsed params and remove invalid params' do
      expect(subject.commands).to eq valid_parms
    end
  end

  describe '.call' do
    context 'when contains invalid params' do
      it_behaves_like 'return valid params'
    end

    context 'when valid params, but dont parsed' do
      let(:params) { 'PLACE:0,1,NORTH MOVE LEFT RIGHT REPORT PLACE:0,2,SOUTH' }

      it 'return parsed params and remove invalid params' do
        expect(subject.commands).to eq valid_parms
      end
    end
  end
end
