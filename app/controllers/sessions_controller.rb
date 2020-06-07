class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] ='ログイン成功！'
      redirect_to tasks_url
    else
      flash.now[:danger] = 'ログイン失敗'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウト成功'
    redirect_to login_path
  end
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      #ログイン成功
      session[:user_id] = @user.id
      return true
    else
      #ログイン失敗
      return false
    end
  end
  
end
