require 'test_helper'

class GeneNamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gene_name = gene_names(:one)
  end

  test "should get index" do
    get gene_names_url
    assert_response :success
  end

  test "should get new" do
    get new_gene_name_url
    assert_response :success
  end

  test "should create gene_name" do
    assert_difference('GeneName.count') do
      post gene_names_url, params: { gene_name: {  } }
    end

    assert_redirected_to gene_name_url(GeneName.last)
  end

  test "should show gene_name" do
    get gene_name_url(@gene_name)
    assert_response :success
  end

  test "should get edit" do
    get edit_gene_name_url(@gene_name)
    assert_response :success
  end

  test "should update gene_name" do
    patch gene_name_url(@gene_name), params: { gene_name: {  } }
    assert_redirected_to gene_name_url(@gene_name)
  end

  test "should destroy gene_name" do
    assert_difference('GeneName.count', -1) do
      delete gene_name_url(@gene_name)
    end

    assert_redirected_to gene_names_url
  end
end
