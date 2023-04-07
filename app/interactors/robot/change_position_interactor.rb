# frozen_string_literal: true

module Robot
  class ChangePositionInteractor
    include Interactor
    include BaseDirectionFacing

    delegate :facing, :place, to: :context

    def call
      change_value_x
      change_value_y
    end

    private

    def change_value_x
      return place[:x] += -1 if west? && valid_x_left?

      place[:x] += 1 if east? && valid_x_right?
    end

    def change_value_y
      return place[:y] += -1 if south? && valid_y_left?

      place[:y] += 1 if north? && valid_y_right?
    end

    def valid_x_left?
      place[:x].positive?
    end

    def valid_y_left?
      place[:y].positive?
    end

    def valid_x_right?
      place[:x] < 4
    end

    def valid_y_right?
      place[:y] < 4
    end
  end
end
