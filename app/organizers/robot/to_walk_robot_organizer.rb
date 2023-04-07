# frozen_string_literal: true

module Robot
  class ToWalkRobotOrganizer
    include Interactor::Organizer

    organize ParseValuesInteractor, RemoveInvalidValuesInteractor, WalkRobotInteractor
  end
end
