class ApplicationsController < ApplicationController
	def new
		reset_session
		@application = Application.new
		@subjects = Subject.all
		@school = School.new
		@subjects_arr = @subjects.map do |s|
			[s.name, s.id]
		end
	end

	def create
		old_applications = Application.where(email: application_params[:email], status: 0)
		old_applications.destroy_all
		@application = Application.new(application_params)
		@application.status = 0
		@subjects = Subject.all
		@subjects_arr = @subjects.map do |s|
			[s.name, s.id]
		end
		@school = School.new(school_params)
		if school_params[:name].blank?
			@school.errors.add(:name, I18n.t("errors.messages.empty"))
		end
		if (not @application.valid?) or school_params[:name].blank?
			render 'new'
		else
			@school = School.find_by(school_params)
			if @school.nil?
				@application.status = 0
				@application.save
				session[:application_id] = @application.id
				@school = School.new(school_params)
				flash.now[:warning] = "ไม่พบข้อมูลโรงเรียน#{@school.name} กรุณากรอกข้อมูล"
				render 'school_info'
			else
				if @school.applications.find_by(subject: @application.subject).nil?
					@application.save
					session[:application_id] = @application.id
					session[:school_id] = @school.id
					flash.now[:info] = "พบข้อมูลโรงเรียน#{@school.name} กรุณาตรวจสอบข้อมูล"
					render 'application_confirm'
				else
					@application.errors.add(:base, "โรงเรียน#{@school.name} ได้มีการสมัครวิชา#{Subject.find_by(id: application_params[:subject_id]).name}แล้ว")
					render 'new'
				end
			end
		end
	end

	def update # Seriously, this is redirected from the confirmation page.
		@application = Application.find_by(id: session[:application_id])
		@school = School.find_by(id: session[:school_id])
		@application.school = @school
		@application.status = 1
		@application.save
		reset_session
		Notifications.signup(@application).deliver
		flash[:success] = "ลงทะเบียนเรียบร้อย ระบบได้ทำการส่งอีเมลไปหาท่าน ซึ่งจะมีลิงค์ยืนยัน กรุณาตรวจสอบอีเมลของท่าน"
		redirect_to root_path
	end

	def confirm
		@application = Application.find_by(id: params[:id], token: params[:token])
		if @application.nil?
			flash[:danger] = "เกิดข้อผิดพลาดกับลิงค์ยืนยัน กรุณาลองใหม่ภายหลัง"
		else
			@application.status = 2
			@application.save
			flash[:success] = "ยืนยันการลงทะเบียนเรียบร้อย กรุณาเข้าสู่ระบบ"
		end
		redirect_to root_path
	end

	private
	def application_params
		params.require(:application).permit(:email, :password, :password_confirmation, :subject_id)
	end

	def school_params
		params.require(:school).permit(:name)
	end
end
