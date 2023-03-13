class PasswordResentsController < ApplicationController
	def new; end
	def edit
		@user = User.find_signed!(params[:token],purpose: 'password_resets')
		recuse ActiveSupport::MessageVerifier::InvalidSinature
		redirect_to sign_in_path,alert: 'your token has expired. please try again!'
	end
	def update
		@user =User.find_signed!(params[:token],purpose: 'password_resets')
		if @user.update(password_params)
			redirect_to sign_in_path, notice: 'your password was reset successfully .please sign in'
		else
			rener :edit
		end
	end
	private
	def password_params
		params.require(:user).permit(:password,:password_confirmation)
	end
end