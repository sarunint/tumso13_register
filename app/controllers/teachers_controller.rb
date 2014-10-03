class TeachersController < ApplicationController
	def new
		if not current_application.teacher_addable?
			redirect_to application_path
		else
			@teacher = current_application.teachers.new
		end
	end

	def create
		@teacher = current_application.teachers.new(teacher_params)
		if @teacher.valid?
			@teacher.save
			app = @teacher.application
			app.revision += 1
			app.save
			redirect_to application_path
		else
			render 'new'
		end
	end

	def edit
		@teacher = current_application.teachers.find_by(id: params[:id])
		if @teacher.nil?
			flash[:danger] = "ไม่พบครู"
			redirect_to application_path
		end
	end

	def update
		teacher = current_application.teachers.find_by(id: params[:id])
		if teacher.nil?
			flash[:danger] = "ไม่พบครู"
		else
			teacher.update(teacher_params)
			app = teacher.application
			app.revision += 1
			app.save
		end
		redirect_to application_path
	end

	def destroy
		teacher = current_application.teachers.find_by(id: params[:id])
		if teacher.nil?
			flash[:danger] = "ไม่พบครู"
		else
			app = teacher.application
			teacher.destroy
			app.revision += 1
			app.save
		end
		redirect_to application_path
	end

	private
	def teacher_params
		params.require(:teacher).permit(:title, :fname, :lname)
	end
end
