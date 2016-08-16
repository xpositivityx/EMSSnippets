class RegisterController < ApplicationController
  skip_before_action :require_login
  
  def new
  	render "new"
  end

  def create
  	@user = User.new(user_params)
    @user.email = params[:email].downcase
  	if !@user.save
  		flash[:notice] = 'User not saved!'
      redirect_to new_register_path
  	else
  	flash[:notice] = 'User Saved!'
    session[:user_id] = @user.id
    session[:time] = Time.now
    @user.send_welcome_email
    redirect_to root_path
  	end
  end

  private

  def user_params
    params.permit(:name, :email, :password,:password_confirmation, :job)
  end
end
