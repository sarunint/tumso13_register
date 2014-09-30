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
			app = @teacher.application
			app.revision += 1
			app.save
			redirect_to application_path
		else
			render 'new'
		end
	end

	def edit
		@teacher = Teacher.find_by(id: params[:id])
		if @teacher.application != current_application
			flash[:danger] = "การกระทำที่น่าสงสัย กรุณาติดต่อผู้พัฒนา"
			redirect_to application_path
		end
	end

	def update
		teacher = Teacher.find_by(id: params[:id])
		if teacher.application != current_application
			flash[:danger] = "การกระทำที่น่าสงสัย กรุณาติดต่อผู้พัฒนา"
		else
			teacher.update(teacher_params)
			app = teacher.application
			app.revision += 1
			app.save
		end
		redirect_to application_path
	end

	def destroy
		teacher = Teacher.find_by(id: params[:id])
		if teacher.application != current_application
			flash[:danger] = "การกระทำที่น่าสงสัย กรุณาติดต่อผู้พัฒนา"
		else
			teacher.destroy
			app = teacher.application
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
