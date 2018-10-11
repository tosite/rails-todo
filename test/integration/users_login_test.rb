require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "ログイン失敗" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: '', password: '' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get '/'
    assert flash.empty?
  end

  test "ログイン成功" do
    get login_path

    post login_path, params: { session: { email: @user.email, password: 'password' } }

    assert is_login?
    assert_redirected_to '/tasks'
    follow_redirect!
    assert_template 'tasks/index'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)

    delete logout_path
    assert_not is_login?
    assert_redirected_to '/'
    follow_redirect!
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', logout_path, count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0
  end
end
