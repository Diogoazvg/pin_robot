# frozen_string_literal: true

module Types
  module Robot
    class MovementRobotType < Types::BaseObject
      field :report_movemets_robot, [String], null: true

      def report_movemets_robot
        object
      end
    end
  end
end
