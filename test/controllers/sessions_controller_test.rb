# good
# frozen_string_literal: true

# Some documentation for Person
require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get sessions_new_url
    assert_response :success
  end
end
