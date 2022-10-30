require "test_helper"

class StatusCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get status_comments_create_url
    assert_response :success
  end

  test "should get destroy" do
    get status_comments_destroy_url
    assert_response :success
  end
end
