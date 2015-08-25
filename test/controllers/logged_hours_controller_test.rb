require 'test_helper'

class LoggedHoursControllerTest < ActionController::TestCase
  setup do
    @logged_hour = logged_hours(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:logged_hours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create logged_hour" do
    assert_difference('LoggedHour.count') do
      post :create, logged_hour: {  }
    end

    assert_redirected_to logged_hour_path(assigns(:logged_hour))
  end

  test "should show logged_hour" do
    get :show, id: @logged_hour
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @logged_hour
    assert_response :success
  end

  test "should update logged_hour" do
    patch :update, id: @logged_hour, logged_hour: {  }
    assert_redirected_to logged_hour_path(assigns(:logged_hour))
  end

  test "should destroy logged_hour" do
    assert_difference('LoggedHour.count', -1) do
      delete :destroy, id: @logged_hour
    end

    assert_redirected_to logged_hours_path
  end
end
