class SessionsController < ApplicationController
  def new
  end

  def create
    input = params[:session]
    user  = User.find_by(email: input[:email].downcase)
    if user
      if user.authenticate(input[:password])
        # OK
        login user
        # redirect_to user
        redirect_to '/tasks', notice: 'ログインしました。'
      else
        flash.now[:danger] = 'パスワードが間違っているようです。'
      end
    else
      flash.now[:danger] = 'メールアドレスが間違っているか、ユーザーが存在しないようです。'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to '/', notice: 'ログアウトしました。'
  end
end
