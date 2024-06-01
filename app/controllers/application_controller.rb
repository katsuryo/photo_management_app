class ApplicationController < ActionController::Base
  private

  def authenticate_user
    @current_user ||= User.find_by(id: session[:user_id])
    
    unless @current_user
      redirect_to root_path, alert: 'ログインしてください'
    end
  end

end
