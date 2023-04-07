# frozen_string_literal: true

module Mutations
  module Robot
    class MovementRobot < BaseMutation
      argument :movement_commands, String, required: true

      type Types::Robot::MovementRobotType

      def resolve(**attrs)
        ::Robot::ToWalkRobotOrganizer.call(values: attrs[:movement_commands]).reports
      end
    end
  end
end
