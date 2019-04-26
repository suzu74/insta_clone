class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
       log_in user
       flash[:success] = "ログインに成功しました!"
       redirect_to user
    else
      flash.now[:danger] = "パスワードかメールに間違いがあります"
      render 'new'
    end
  end
  
  def destroy
    log_out
    flash[:success] = "ログアウトしました！"
    redirect_to root_path
  end
  
end
