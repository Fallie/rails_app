require 'test_helper'

class StaticViewsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_views_home_url
    assert_response :success
    assert_select "title", "HomePage|Rails App"
  end

end
