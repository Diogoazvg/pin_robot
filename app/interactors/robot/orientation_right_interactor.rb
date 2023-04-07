# frozen_string_literal: true

module Robot
  class OrientationRightInteractor
    include Interactor
    include BaseDirectionFacing

    delegate :facing, to: :context

    def call
      context.orientation = orientation_right
    end

    private

    def orientation_right
      return :east if north?
      return :south if east?
      return :west if south?

      :north
    end
  end
end
