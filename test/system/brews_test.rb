require "application_system_test_case"

class BrewsTest < ApplicationSystemTestCase
  setup do
    @brew = brews(:one)
  end

  test "visiting the index" do
    visit brews_url
    assert_selector "h1", text: "Brews"
  end

  test "should create brew" do
    visit brews_url
    click_on "New brew"

    fill_in "Name", with: @brew.name
    fill_in "State", with: @brew.state
    click_on "Create Brew"

    assert_text "Brew was successfully created"
    click_on "Back"
  end

  test "should update Brew" do
    visit brew_url(@brew)
    click_on "Edit this brew", match: :first

    fill_in "Name", with: @brew.name
    fill_in "State", with: @brew.state
    click_on "Update Brew"

    assert_text "Brew was successfully updated"
    click_on "Back"
  end

  test "should destroy Brew" do
    visit brew_url(@brew)
    accept_confirm { click_on "Destroy this brew", match: :first }

    assert_text "Brew was successfully destroyed"
  end
end
