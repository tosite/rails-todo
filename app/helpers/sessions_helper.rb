module SessionsHelper
  def login(user)
    session[:user_id] = user.id
  end

  def auth
    if session[:user_id]
      @auth ||= User.find_by(id: session[:user_id])
    end
  end

  def is_login?
    !auth.nil?
  end

  def logout
    session.delete(:user_id)
    @auth = nil
  end
end
