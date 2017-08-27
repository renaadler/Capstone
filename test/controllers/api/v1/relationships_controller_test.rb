require 'test_helper'

class Api::V1::RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_relationships_create_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_relationships_show_url
    assert_response :success
  end

end
