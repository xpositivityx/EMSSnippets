class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login

  private

  def require_login
  	unless session[:user_id] && session[:time] > (Time.now - (60 * 60 * 3) )
  		flash[:error] = "You must be logged in to view this page"
      session[:user_id] = nil
  		redirect_to new_session_path
  	end
  end
end
