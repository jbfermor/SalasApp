require "application_system_test_case"

class TechesTest < ApplicationSystemTestCase
  setup do
    @tech = teches(:one)
  end

  test "visiting the index" do
    visit teches_url
    assert_selector "h1", text: "Teches"
  end

  test "should create tech" do
    visit teches_url
    click_on "New tech"

    fill_in "Name", with: @tech.name
    fill_in "User", with: @tech.user_id
    click_on "Create Tech"

    assert_text "Tech was successfully created"
    click_on "Back"
  end

  test "should update Tech" do
    visit tech_url(@tech)
    click_on "Edit this tech", match: :first

    fill_in "Name", with: @tech.name
    fill_in "User", with: @tech.user_id
    click_on "Update Tech"

    assert_text "Tech was successfully updated"
    click_on "Back"
  end

  test "should destroy Tech" do
    visit tech_url(@tech)
    click_on "Destroy this tech", match: :first

    assert_text "Tech was successfully destroyed"
  end
end
