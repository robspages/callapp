require 'test_helper'

class CallersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @caller = callers(:one)
  end

  test "should get index" do
    get callers_url
    assert_response :success
  end

  test "should get new" do
    get new_caller_url
    assert_response :success
  end

  test "should create caller" do
    assert_difference('Caller.count') do
      post callers_url, params: { caller: { name: @caller.name, notes: @caller.notes, original_title: @caller.original_title } }
    end

    assert_redirected_to caller_url(Caller.last)
  end

  test "should show caller" do
    get caller_url(@caller)
    assert_response :success
  end

  test "should get edit" do
    get edit_caller_url(@caller)
    assert_response :success
  end

  test "should update caller" do
    patch caller_url(@caller), params: { caller: { name: @caller.name, notes: @caller.notes, original_title: @caller.original_title } }
    assert_redirected_to caller_url(@caller)
  end

  test "should destroy caller" do
    assert_difference('Caller.count', -1) do
      delete caller_url(@caller)
    end

    assert_redirected_to callers_url
  end
end
