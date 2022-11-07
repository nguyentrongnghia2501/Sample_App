# good
# frozen_string_literal: true

# Some documentation for Person
require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get users_new_url
    assert_response :success
  end
end
