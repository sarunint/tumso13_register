class SessionsController < ApplicationController
	def new
		if current_application
			flash[:info] = 'คุณอยู่ในระบบเรียบร้อยแล้ว'
			redirect_to application_path
		else
			@application = Application.new
			@session = Session.new
		end
	end

	def create
		@application = Application.find_by(email: params[:application][:email])
		@application = @application.authenticate(params[:application][:password])
		if @application == false
			@application = Application.new(email: params[:application][:email])
			flash.now[:danger] = 'อีเมล์ หรือรหัสผ่านไม่ถูกต้อง'
			render 'new'
		else
			sign_in @application
			flash[:success] = "ยินดีต้อนรับ โรงเรียน#{@application.school.name}"
			redirect_to application_path
		end
	end

	def destroy
		sign_out
		flash[:info] = "คุณได้ออกจากระบบแล้ว"
		redirect_to root_path
	end
end
