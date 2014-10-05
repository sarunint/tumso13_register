class TeamsController < ApplicationController
	before_action :application_required

	def create
		team = current_application.teams.new
		team.save
		app = team.application
		app.revision += 1
		app.save
		redirect_to application_path
	end

	def destroy
		team = current_application.teams.find_by(id: params[:id])
		if team.nil?
			flash[:danger] = "ไม่พบทีม"
		else
			team.destroy
			app = team.application
			app.revision += 1
			app.save
		end
		redirect_to application_path
	end
end
