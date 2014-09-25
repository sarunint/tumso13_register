class TeachersController < ApplicationController
	def new
		if not current_application.teacher_addable?
			redirect_to application_path
		else
			@teacher = Teacher.new
		end
	end

	def create
		@teacher = current_application.teachers.new(teacher_params)
		if @teacher.valid?
			@teacher.save
			redirect_to application_path
		else
			render 'new'
		end
	end

	def destroy
		teacher = Teacher.find_by(id: params[:id])
		if teacher.application != current_application
			flash[:danger] = "การกระทำที่น่าสงสัย กรุณาติดต่อผู้พัฒนา"
		else
			teacher.destroy
			redirect_to application_path
		end
	end

	private
	def teacher_params
		params.require(:teacher).permit(:title, :fname, :lname)
	end
end
