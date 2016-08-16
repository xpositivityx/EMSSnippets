class ErrorController < ApplicationController
	def new
		@user = User.find(session[:user_id])
		render 'new'
	end

	def create
		@error = {
			log: params[:errorlog],
			description: params[:description],
			comments: params[:comments],
			user: params[:email]
		}
		ErrorMailer.error_email(@error).deliver
		flash[:success] = 'Error notification sent.'
		redirect_to test_index_path
	end
end
