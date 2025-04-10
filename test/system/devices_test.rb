require "application_system_test_case"

class DevicesTest < ApplicationSystemTestCase
  setup do
    @device = devices(:one)
  end

  test "visiting the index" do
    visit devices_url
    assert_selector "h1", text: "Devices"
  end

  test "should create device" do
    visit devices_url
    click_on "New device"

    fill_in "Connection state", with: @device.connection_state
    fill_in "Mac address", with: @device.mac_address
    fill_in "Name", with: @device.name
    fill_in "Ratp", with: @device.ratp_id
    fill_in "Type", with: @device.type
    click_on "Create Device"

    assert_text "Device was successfully created"
    click_on "Back"
  end

  test "should update Device" do
    visit device_url(@device)
    click_on "Edit this device", match: :first

    fill_in "Connection state", with: @device.connection_state
    fill_in "Mac address", with: @device.mac_address
    fill_in "Name", with: @device.name
    fill_in "Ratp", with: @device.ratp_id
    fill_in "Type", with: @device.type
    click_on "Update Device"

    assert_text "Device was successfully updated"
    click_on "Back"
  end

  test "should destroy Device" do
    visit device_url(@device)
    accept_confirm { click_on "Destroy this device", match: :first }

    assert_text "Device was successfully destroyed"
  end
end
