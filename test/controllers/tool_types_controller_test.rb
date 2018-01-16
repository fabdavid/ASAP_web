require 'test_helper'

class ToolTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tool_type = tool_types(:one)
  end

  test "should get index" do
    get tool_types_url
    assert_response :success
  end

  test "should get new" do
    get new_tool_type_url
    assert_response :success
  end

  test "should create tool_type" do
    assert_difference('ToolType.count') do
      post tool_types_url, params: { tool_type: {  } }
    end

    assert_redirected_to tool_type_url(ToolType.last)
  end

  test "should show tool_type" do
    get tool_type_url(@tool_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_tool_type_url(@tool_type)
    assert_response :success
  end

  test "should update tool_type" do
    patch tool_type_url(@tool_type), params: { tool_type: {  } }
    assert_redirected_to tool_type_url(@tool_type)
  end

  test "should destroy tool_type" do
    assert_difference('ToolType.count', -1) do
      delete tool_type_url(@tool_type)
    end

    assert_redirected_to tool_types_url
  end
end
