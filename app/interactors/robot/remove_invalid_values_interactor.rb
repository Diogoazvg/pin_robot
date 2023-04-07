# frozen_string_literal: true

module Robot
  class RemoveInvalidValuesInteractor
    include Interactor

    delegate :commands, to: :context

    def call
      commands_without_invalid_values
    end

    private

    def invalid_values?(array_value)
      x_y_limit = (0..4)
      array_value.any? { |value| x_y_limit.exclude?(value) }
    end

    def commands_without_invalid_values
      clear_commands = []
      last_valid_place = true
      commands.each do |command|
        command.each do |key, value|
          if place?(key)
            remove_facing = value[0..1]
            if invalid_values?(remove_facing)
              last_valid_place = false
              next
            end

            last_valid_place = true
          end

          clear_commands << command if last_valid_place
        end
      end
      context.clear_commands = clear_commands
    end

    def place?(key)
      key == :place
    end
  end
end
