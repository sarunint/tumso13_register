class StudentsController < ApplicationController
	before_action :application_required

	def new
		team = current_application.teams.find_by(id: params[:team_id])
		if team.nil?
			flash[:danger] = "ไม่พบทีม"
			redirect_to application_path
		else
			@student = team.students.new
		end
	end

	def create
		team = current_application.teams.find_by(id: params[:team_id])
		if team.nil?
			flash[:danger] = "ไม่พบทีม"
			redirect_to application_path
		else
			@student = team.students.new(student_params)
			if @student.valid?
				@student.save
				app = team.application
				app.revision += 1
				app.save
				redirect_to application_path
			else
				render 'new'
			end
		end
	end

	def edit
		team = Team.find_by(id: params[:team_id])
		if team.nil?
			flash[:danger] = "ไม่พบทีม"
			redirect_to application_path
		else
			@student = team.students.find_by(id: params[:id])
			if @student.nil?
				flash[:danger] = "ไม่พบนักเรียน"
				redirect_to application_path
			end
		end
	end

	def update
		team = Team.find_by(id: params[:team_id])
		if team.nil?
			flash[:danger] = "ไม่พบทีม"
			redirect_to application_path
		else
			@student = team.students.find_by(id: params[:id])
			if @student.nil?
				flash[:danger] = "ไม่พบนักเรียน"
				redirect_to application_path
			else
				@student = @student.update(student_params)
				app = team.application
				app.revision += 1
				app.save
				redirect_to application_path
			end
		end
	end

	def destroy
		team = Team.find_by(id: params[:team_id])
		if team.nil?
			flash[:danger] = "ไม่พบทีม"
			redirect_to application_path
		else
			student = team.students.find_by(id: params[:id])
			if student.nil?
				flash[:danger] = "ไม่พบนักเรียน"
				redirect_to application_path
			else
				student.destroy
				app = team.application
				app.revision += 1
				app.save
				redirect_to application_path
			end
		end
	end

	private
	def student_params
		params.require(:student).permit(:title, :fname, :lname)
	end
end
