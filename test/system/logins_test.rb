require "application_system_test_case"

class LoginsTest < ApplicationSystemTestCase
  setup do
    @u1 = users(:u1)
    @u2 = users(:u2)
  end

  test "u1 login success" do
    visit login_page_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: '123456'
    click_on "Log in"
    assert_text "You are logging in as: ".concat(@u1.name)
  end

  test "u2 login success" do
    visit login_page_url
    fill_in "Email", with: @u2.email
    fill_in "Password", with: '123456'
    click_on "Log in"
    assert_text "You are logging in as: ".concat(@u2.name)
  end

  test "u1 login failed" do
    visit login_page_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: '12345678'
    click_on "Log in"
    assert_text "Your email or password is incorrect!"
  end

  test "u1 login but not enter password" do
    visit login_page_url
    fill_in "Email", with: @u1.email
    click_on "Log in"
    assert_text "Your email or password is incorrect!"
  end

  test "u1 login but not enter email" do
    visit login_page_url
    fill_in "Password", with: '123456'
    click_on "Log in"
    assert_text "Your email or password is incorrect!"
  end

  test "login but not enter anything" do
    visit login_page_url
    click_on "Log in"
    assert_text "Your email or password is incorrect!"
  end

end
