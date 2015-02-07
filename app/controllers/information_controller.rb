class InformationController < ApplicationController
	def create
		@resume = Resume.find(params[:resume_id])
		@information = @resume.information.create(information_params)
		redirect_to resume_path(@resume)
	end

	private
		def information_params
			params.require(:comment).permit(:firstname,:middlename,:lastname,:email,:phone,:street,:city,:state,:zipcode)	
		end
end
