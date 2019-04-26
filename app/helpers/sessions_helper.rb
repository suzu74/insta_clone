module SessionsHelper
  #ユーザーのログイン
  def log_in(user)
    session[:user_id] = user.id
  end
  
  #ログインしているユーザー
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  #ログインしているかのチェック
  def logged_in?
    !current_user.nil?
  end
  
  # ログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
