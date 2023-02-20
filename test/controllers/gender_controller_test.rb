require "test_helper"

class GenderControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get gender_top_url
    assert_response :success
  end
end
