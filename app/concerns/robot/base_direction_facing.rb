# frozen_string_literal: true

module Robot
  module BaseDirectionFacing
    def west?
      facing == :west
    end

    def south?
      facing == :south
    end

    def east?
      facing == :east
    end

    def north?
      facing == :north
    end
  end
end
