class TeamsController < ApplicationController
	def create
		team = current_application.teams.new
		team.save
		redirect_to application_path
	end
end
