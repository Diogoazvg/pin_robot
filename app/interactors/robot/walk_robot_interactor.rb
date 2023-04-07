# frozen_string_literal: true

module Robot
  class WalkRobotInteractor
    include Interactor

    delegate :clear_commands, :report, :facing, :place, to: :context

    def call
      context.reports = []
      context.facing = :north
      context.place = { x: 0, y: 0, f: :north }
      place_possition
    end

    private

    def place_possition
      clear_commands.each do |object|
        object.each do |key, value|
          case key
          when :place
            context.place = hash_place(value)
            context.facing = value[2]
          when :left
            context.facing = orientation_left
          when :right
            context.facing = orientation_right
          when :move
            chage_position
          when :report
            place_to_report
          end
          context.place[:f] = facing
        end
      end
      context.reports << place
      to_string_reports
    end

    def hash_place(value)
      { x: value[0], y: value[1], f: value[2] }
    end

    def place_to_report
      context.reports << { x: place[:x], y: place[:y], f: place[:f] }
    end

    def to_string_reports
      context.reports = context.reports.map { |r| r.values.join(',').upcase }
    end

    def orientation_left
      OrientationLeftInteractor.call(facing:).orientation
    end

    def orientation_right
      OrientationRightInteractor.call(facing:).orientation
    end

    def chage_position
      ChangePositionInteractor.call(facing:, place:)
    end
  end
end
