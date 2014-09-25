module SessionsHelper
	def sign_in(application)
		token = Session.generate_token
		session = application.sessions.new(remember_token: Digest::SHA512.hexdigest(token))
		cookies.permanent[:remember_token] = token
		session.save
	end

	def sign_out
		token = cookies[:remember_token]
		if not token.nil?
			session = Session.find_by(remember_token: Digest::SHA512.hexdigest(token))
			cookies.delete(:remember_token)
			session.destroy unless session.nil?
		end
	end

	def current_application=(application)
		@current_application = application
	end

	def current_application
		if @current_application.nil?
			token = cookies[:remember_token]
			session = Session.find_by(remember_token: Digest::SHA512.hexdigest(token)) unless token.nil?
			if token.nil? or session.nil?
				cookies.delete(:remember_token)
				nil
			else
				session.application
			end
		else
			@current_application
		end
	end

	def application_required
		if current_application.nil?
			flash[:warning] = "กรุณาเข้าศุ่ระบบก่อน"
			redirect_to new_session_path
		end
	end
end
