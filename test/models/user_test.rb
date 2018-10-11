require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "user", email: 'test@example.com', password: 'password', password_confirmation: 'password')
  end

  test "検証成功" do
    assert @user.valid?
  end

  test "検証失敗_nameが空白" do
    @user.name = ' '
    assert_not @user.valid?
  end

  test "検証失敗_Emailが空白" do
    @user.email = ' '
    assert_not @user.valid?
  end

  test "検証失敗_nameが長すぎる" do
    @user.name = 'a' * 50
    assert_not @user.valid?
  end

  test "検証失敗_emailが長すぎる" do
    @user.email = 'a' * 300
    assert_not @user.valid?
  end

  test "検証成功_email" do
    valids = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                first.last@foo.jp alice+bob@baz.cn]
     valids.each do |adr|
      @user.email = adr
      assert @user.valid?, "#{adr.inspect} は通るべきです。"
    end
  end

  test "検証失敗_email" do
    invalids = %w[user@example,com user_at_foo.org user.name@example.
                  foo@bar_baz..com foo@bar+baz.com]
     invalids.each do |adr|
      @user.email = adr
      assert_not @user.valid?, "#{adr.inspect} は通るべきではありません。"
    end
  end

  test "検証失敗_emailがすでに存在している_大文字" do
    duplicate = @user.dup
    duplicate.email = @user.email.upcase
    @user.save
    assert_not duplicate.valid?
  end

  test "検証失敗_emailがすでに存在している_小文字" do
    mixed = "Text@EXaMplE.CoM"
    @user.email = mixed
    @user.save
    assert_equal mixed.downcase, @user.reload.email
  end

  test "検証失敗_passwordが空白" do
    @user.password = @user.password_confirmation = " " * 8
    assert_not @user.valid?
  end

  test "検証失敗_password長が足りない" do
    @user.password = @user.password_confirmation = "a" * 4
    assert_not @user.valid?
  end

  test "" do
  end
end
