class PasswordresetController < ApplicationController
skip_before_action :require_login
	def new
		render :new
	end

	def create
		user = User.where(email: params[:email]).first
		user.send_password_reset if user
		flash[:notice] = "Email sent with password reset instructions."
		redirect_to new_session_url 
	end

	def edit
		@user = User.where(password_reset: params[:id]).first
	end

	def update
		@user = User.where(password_reset: params[:id]).first
		if @user.password_reset_sent < 2.hours.ago
			flash[:notice] = 'Password reset has expired'
			redirect_to new_passwordreset_path
		elsif @user.update_attributes(params.permit![:user])
			flash[:notice] = "Password updated"
			redirect_to new_session_path
		else
			render :edit
		end
	end

	def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation, :job)
  end
end
