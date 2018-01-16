require 'test_helper'

class DbSetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @db_set = db_sets(:one)
  end

  test "should get index" do
    get db_sets_url
    assert_response :success
  end

  test "should get new" do
    get new_db_set_url
    assert_response :success
  end

  test "should create db_set" do
    assert_difference('DbSet.count') do
      post db_sets_url, params: { db_set: {  } }
    end

    assert_redirected_to db_set_url(DbSet.last)
  end

  test "should show db_set" do
    get db_set_url(@db_set)
    assert_response :success
  end

  test "should get edit" do
    get edit_db_set_url(@db_set)
    assert_response :success
  end

  test "should update db_set" do
    patch db_set_url(@db_set), params: { db_set: {  } }
    assert_redirected_to db_set_url(@db_set)
  end

  test "should destroy db_set" do
    assert_difference('DbSet.count', -1) do
      delete db_set_url(@db_set)
    end

    assert_redirected_to db_sets_url
  end
end
