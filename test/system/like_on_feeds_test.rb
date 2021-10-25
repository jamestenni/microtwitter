require "application_system_test_case"

class LikeOnFeedsTest < ApplicationSystemTestCase
  setup do
    @testlike_u1 = users(:testlikeu1)
    @testlike_u2 = users(:testlikeu2)
    @post = posts(:p1)
  end

  test "u2 like u1 post" do
    #Login with testlike_u2
    visit login_page_url
    fill_in "Email", with: @testlike_u2.email
    fill_in "Password", with: '123456'
    click_on "Log in"

    #go to testlike_u1 profile page and follow
    visit profile_page_path(name: @testlike_u1.name)
    click_on "Follow"

    #go back to feed page, should see testlike_u1 post
    click_on "Home"
    click_on "Like", match: :first

    #go to check testlike_u1 profile to see that the like is shown or not
    click_on @testlike_u1.name
    assert_text "Liked by"
    assert_text @testlike_u2.name
  end
end
