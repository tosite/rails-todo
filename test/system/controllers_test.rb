require "application_system_test_case"

class ControllersTest < ApplicationSystemTestCase
  setup do
    @controller = controllers(:one)
  end

  test "visiting the index" do
    visit controllers_url
    assert_selector "h1", text: "Controllers"
  end

  test "creating a Controller" do
    visit controllers_url
    click_on "New Controller"

    fill_in "Users", with: @controller.users
    click_on "Create Controller"

    assert_text "Controller was successfully created"
    click_on "Back"
  end

  test "updating a Controller" do
    visit controllers_url
    click_on "Edit", match: :first

    fill_in "Users", with: @controller.users
    click_on "Update Controller"

    assert_text "Controller was successfully updated"
    click_on "Back"
  end

  test "destroying a Controller" do
    visit controllers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Controller was successfully destroyed"
  end
end
