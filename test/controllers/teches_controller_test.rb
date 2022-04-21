require "test_helper"

class TechesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tech = teches(:one)
  end

  test "should get index" do
    get teches_url
    assert_response :success
  end

  test "should get new" do
    get new_tech_url
    assert_response :success
  end

  test "should create tech" do
    assert_difference("Tech.count") do
      post teches_url, params: { tech: { name: @tech.name, user_id: @tech.user_id } }
    end

    assert_redirected_to tech_url(Tech.last)
  end

  test "should show tech" do
    get tech_url(@tech)
    assert_response :success
  end

  test "should get edit" do
    get edit_tech_url(@tech)
    assert_response :success
  end

  test "should update tech" do
    patch tech_url(@tech), params: { tech: { name: @tech.name, user_id: @tech.user_id } }
    assert_redirected_to tech_url(@tech)
  end

  test "should destroy tech" do
    assert_difference("Tech.count", -1) do
      delete tech_url(@tech)
    end

    assert_redirected_to teches_url
  end
end
