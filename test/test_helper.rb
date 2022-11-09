# good
# frozen_string_literal: true

# Some documentation for Person
# good
# have each child on its own line
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
class ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors)
    fixtures :all
    # Add more helper methods to be used by all tests here...
  end
end
