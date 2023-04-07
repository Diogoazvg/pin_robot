# frozen_string_literal: true

module Robot
  class ParseValuesInteractor
    PERMIT_VALUES = %w[PLACE NORTH MOVE LEFT RIGHT REPORT].freeze
    include Interactor

    delegate :values, :reports, to: :context

    def call
      context.commands = parse_values
    end

    private

    def parse_values
      split_values.map do |value|
        if place_permited?(value)
          { place: value.values.first.map! do |place_value|
                     place_value.is_a?(String) ? place_value.downcase.to_sym : place_value
                   end.flatten }
        elsif permited?(value)
          { "#{value.downcase}": true }
        end
      end.compact
    end

    def split_values
      splited = []
      values.split.each do |value|
        if place?(value)
          split_place = value.split(':') if place?(value)
          split_place_values = split_place[1].split(',')
          number_values = split_place_values[0..1].map(&:to_i)

          splited << { PLACE: number_values.push(split_place_values[2]) }
        else
          splited << value
        end
      end
      splited
    end

    def place_permited?(value)
      value.is_a?(Hash) && permited?(value.keys.first.to_s)
    end

    def permited?(value)
      value.in?(PERMIT_VALUES)
    end

    def place?(value)
      value.match?('PLACE')
    end
  end
end
