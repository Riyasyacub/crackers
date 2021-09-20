require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get crack_show" do
    get orders_crack_show_url
    assert_response :success
  end
end
