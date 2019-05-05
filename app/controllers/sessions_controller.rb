class SessionsController < ApplicationController
  def create
    user = User.find_by(name: params[:session][:name])
    # authenticateメソッド は userモデル に has_secure_password 指定したことで自動で使えるようになる
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to mypage_path
    else
      if user
        redirect_back(fallback_location: root_path)
        flash[:error_messages] = ['パスワードが間違っています']
      else
        redirect_back(fallback_location: root_path)
        flash[:error_messages] = ['未登録のユーザーです']
      end
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
