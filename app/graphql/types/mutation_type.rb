# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :movement_robot, mutation: Mutations::Robot::MovementRobot
  end
end
