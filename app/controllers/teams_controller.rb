class TeamsController < ApplicationController
	def create
		team = current_application.teams.new
		team.save
		app = team.application
		app.revision += 1
		app.save
		redirect_to application_path
	end

	def destroy
		team = Team.find_by(id: params[:id])
		if team.application != current_application
			flash[:danger] = "การกระทำที่น่าสงสัย กรุณาติดต่อผู้พัฒนา"
		else
			team.destroy
			app = team.application
			app.revision += 1
			app.save
		end
		redirect_to application_path
	end
end
