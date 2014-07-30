class SessionsController < ApplicationController
	def new 

	end

	def create
		user = User.where(username: params[:username]).first
		if user && user.authenticate(params[:password])
			if user.two_factor_auth?
				session[:two_factor] = true
				# gen a pin
				user.generate_pin!
				# send pin to twilio, sms to user's phone
				user.send_pin_to_twilio
				

			else

				session[:user_id] = user.id
				flash[:notice] = "welcome, you've logged in."
				redirect_to root_path
			end
		else
			flash[:error] = "There is something wrong with your username or password."
			redirect_to login_path
		end
	end

	def destory
		session[:user_id] = nil
		flash[:notice] = "You've logged out."
		redirect_to root_path
	end

	def pin
		access_denied if session[:two_factor].nil?


		if request.post?
			user = User.find_by pin: params[:pin]
			if user
				session[:two_factor] = nil
				#remove pin
				user.remove_pin!
				# normal login success
				session[:user_id] = user.id
				flash[:notice] = "welcome, you've logged in."
				redirect_to root_path

			else
				flash[:error] = "Sorry something is wrong with your pin number"
				redirect_to pin_path
		end		
	end
end

end
