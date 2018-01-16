require 'test_helper'

class GeneSetNamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gene_set_name = gene_set_names(:one)
  end

  test "should get index" do
    get gene_set_names_url
    assert_response :success
  end

  test "should get new" do
    get new_gene_set_name_url
    assert_response :success
  end

  test "should create gene_set_name" do
    assert_difference('GeneSetName.count') do
      post gene_set_names_url, params: { gene_set_name: {  } }
    end

    assert_redirected_to gene_set_name_url(GeneSetName.last)
  end

  test "should show gene_set_name" do
    get gene_set_name_url(@gene_set_name)
    assert_response :success
  end

  test "should get edit" do
    get edit_gene_set_name_url(@gene_set_name)
    assert_response :success
  end

  test "should update gene_set_name" do
    patch gene_set_name_url(@gene_set_name), params: { gene_set_name: {  } }
    assert_redirected_to gene_set_name_url(@gene_set_name)
  end

  test "should destroy gene_set_name" do
    assert_difference('GeneSetName.count', -1) do
      delete gene_set_name_url(@gene_set_name)
    end

    assert_redirected_to gene_set_names_url
  end
end
