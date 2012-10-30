require 'test_helper'

class StatsControllerTest < ActionController::TestCase
  test "should get view" do
    get :view
    assert_response :success
  end

  test "should get detail" do
    get :detail
    assert_response :success
  end

end
