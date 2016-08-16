class SessionController < ApplicationController
  skip_before_action :require_login
   
  def new
    session[:time] ||= Time.now - (60 * 60 * 4)
    if session[:time] < Time.now - (60 * 60 * 3)
      session[:user_id] = nil
      render "new"
    elsif session[:time] > Time.now - (60 * 60 * 3) && session[:user_id]
      redirect_to test_index_path
    end
  end 

  def create
  	user = User.find_by(email: params[:email])
  	if user.try(:authenticate, params[:password])
  		session[:user_id] = user.id
      session[:time] = Time.now
  		if user.email.downcase == 'xpositivityx@gmail.com' || 
      user.email.downcase == 'kwilliamsmd@gmail.com'
        session[:is_admin] = true
      else
        session[:is_admin] = false
      end
  		redirect_to test_index_path
  	else
  		flash[:notice] = "incorrect username or password"
      @email = params[:email]
  		render "new"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	flash[:notice] = "Logged Out"
  	redirect_to new_session_path
  end
end
