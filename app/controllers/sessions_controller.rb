class SessionsController < ApplicationController
  def new
  #  loginのview
  end

  def create
    if params_missing?
      render :new, status: :unprocessable_entity
      return
    end

    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to login_path, notice: "Logged in successfully"
    else
      flash[:alert] = "・ユーザ名とパスワードが一致しません"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    p "destroy"
  end

  private

  def params_missing?
    error_messages = []
    if params[:username].blank?
      error_messages << "・ユーザ名を入力してください"
    end

    if params[:password].blank?
      error_messages << "・パスワードを入力してください"
    end

    unless error_messages.empty?
      flash[:alert] = error_messages.join("<br>")
      return true
    end
    false
  end
end