# frozen_string_literal: true

module Robot
  class OrientationLeftInteractor
    include Interactor
    include BaseDirectionFacing

    delegate :facing, to: :context

    def call
      context.orientation = orientation_left
    end

    private

    def orientation_left
      return :west if north?
      return :south if west?
      return :east if south?

      :north
    end
  end
end
