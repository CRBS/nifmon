require 'test_helper'

class PollControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

end
