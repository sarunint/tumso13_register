class SchoolsController < ApplicationController
	def create
		@school = School.new(school_params)
		if not @school.valid?
			render 'applications/school_info'
		else
			@school.save
			@application = Application.find_by(id: session[:application_id])
			session[:school_id] = @school.id
			flash.now[:success] = "บันทึกข้อมูลโรงเรียน#{@school.name}เรียบร้อย"
			render 'applications/application_confirm'
		end
	end

	private
	def school_params
		params.require(:school).permit(:name, :number, :soi, :road, :subdistrict, :district, :province, :zip, :telephone, :fax, :website)
	end
end
