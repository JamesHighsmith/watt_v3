require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

  test "should get participate" do
    get :participate
    assert_response :success
  end

  test "should get submit_project" do
    get :submit_project
    assert_response :success
  end

  test "should get research" do
    get :research
    assert_response :success
  end

  test "should get evaluate" do
    get :evaluate
    assert_response :success
  end

  test "should get design" do
    get :design
    assert_response :success
  end

  test "should get finalize" do
    get :finalize
    assert_response :success
  end

  test "should get browse_investments" do
    get :browse_investments
    assert_response :success
  end

  test "should get install" do
    get :install
    assert_response :success
  end

  test "should get earn" do
    get :earn
    assert_response :success
  end

  test "should get learn_more" do
    get :learn_more
    assert_response :success
  end

  test "should get how_watt_works" do
    get :how_watt_works
    assert_response :success
  end

  test "should get blog" do
    get :blog
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get signup" do
    get :signup
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

end
