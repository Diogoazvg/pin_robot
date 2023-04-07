# frozen_string_literal: true

require 'simplecov'

SimpleCov.profiles.define 'root' do
  load_profile 'default'
  minimum_coverage 0
  merge_timeout 3600
end

SimpleCov.start do
  add_filter 'config'
  add_filter 'spec'
  add_filter 'task'
  add_filter(/\w+_schema.rb/)
  add_filter 'app/controllers/graphql_controller.rb'
end
