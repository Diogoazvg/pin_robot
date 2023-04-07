# frozen_string_literal: true

require 'rails_helper'

shared_context 'with graphql query request' do
  let(:graphql_params) { { params: { query: } } }

  def post_request
    post '/graphql', params: { query: }
  end
end

describe 'Movement Robot', type: :request do
  include_context 'with graphql query request'

  subject { JSON.parse(response.body).deep_symbolize_keys[:data][:movementRobot] }

  let!(:query) do
    <<-GRAPHQL
    mutation{
      movementRobot(
        input:{
          movementCommands: "#{place}"
        }
        ) {
          reportMovemetsRobot
        }
      }
    GRAPHQL
  end

  before { post_request }

  shared_examples 'correctly report' do
    it { expect(subject).to eq(reportMovemetsRobot: ['1,0,NORTH', '1,1,NORTH', '1,2,NORTH']) }
  end

  context 'with invalid params' do
    let(:place) { 'PLACE:1,0,NORTH REPORT MOVE 1 355 REPORT MOVE' }

    it_behaves_like 'correctly report'
  end

  context 'with valid params' do
    let(:place) { 'PLACE:1,0,NORTH REPORT MOVE REPORT MOVE' }

    it_behaves_like 'correctly report'
  end
end
