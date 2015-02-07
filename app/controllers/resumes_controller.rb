class ResumesController < ApplicationController

	def parse
		@resume = Resume.new
		@resume.title = params[:answer]
		@resume.date = "WOOO"
		@resume.save

		redirect_to resumes_path
	end
	def index
		@resumes = Resume.all 
		@resumeliststring=""
		@resumes.each do |x|
			@resumestring = ["RES",x.title,x.date,"~"].join("*")
			@information = Information.find_by(resume_id: x.id)
			if(@information!=nil)
				@infostring = ["INF",@information.firstname,@information.middlename,@information.lastname,@information.phone,@information.street,@information.city, @information.state,@information.zipcode,"~"].join("*")
			else
				@infostring=""
			end
			@objectivestring=""
			x.objective.each do |x|
				@objectivestring+= ["OBJ",x.position,x.date,x.fulltime,"~"].join("*")
			end
			@educationstring=""
			x.education.each do |x|
				@educationstring+= ["EDU",x.school,x.schoolcode,x.city,x.state,x.degreetype,x.degree,x.graddate,x.mgpa,x.gpa,"~"].join("*")
			end
			@workstring=""
			x.work.each do |x|
				@workstring += ["WRK",x.company,x.position,x.datestart,x.dateend,"~"].join("*")
			end
			@resumeliststring+=@resumestring+@infostring+@objectivestring+@educationstring+@workstring
		end
	end
	def show
		@resume = Resume.find(params[:id])
		@education = Education.find_by(resume_id: @resume.id)
		@information = Information.find_by(resume_id: @resume.id)
		@infostring = ["INF",@information.firstname,@information.middlename,@information.lastname,@information.phone,@information.street,@information.city, @information.state,@information.zipcode,"~"].join("*")
		@objectivestring=""
		@resume.objective.each do |x|
			@objectivestring+= ["OBJ",x.position,x.date,x.fulltime,"~"].join("*")
		end
		@educationstring=""
		@resume.education.each do |x|
			@educationstring+= ["EDU",x.school,x.schoolcode,x.city,x.state,x.degreetype,x.degree,x.graddate,x.mgpa,x.gpa,"~"].join("*")
		end
		@workstring=""
		@resume.work.each do |x|
			@workstring += ["WRK",x.company,x.position,x.datestart,x.dateend,"~"].join("*")
		end


	end

	def new
		@resume = Resume.new
	end

	def edit
		@resume = Resume.find(params[:id])
	end

	def create
		@resume = Resume.new(resume_params)
		@resume.save
		@information = Information.new
		@information.resume_id= @resume.id
		@information.firstname = params[:informationfname]
		@information.middlename = params[:INFmiddle]
		@information.lastname = params[:INFlastname]
		@information.phone = params[:INFphone]
		@information.street = params[:INFstreet]
		@information.city = params[:INFcity]
		@information.state = params[:INFstate]
		@information.zipcode = params[:INFzip]
		@information.save

		@objective = Objective.new
		@objective.resume_id = @resume.id
		@objective.position = params[:OBJposition]
		@objective.date = params[:OBJdate]
		@objective.fulltime = params[:OBJfull]
		@objective.save

		@education = Education.new
		@education.resume_id = @resume.id
		@education.school = params[:EDUschool]
		@education.schoolcode = params[:EDUcode]
		@education.city = params[:EDUcity]
		@education.state = params[:EDUstate]
		@education.degree = params[:EDUdegree]
		@education.degreetype = params[:EDUtype]
		@education.graddate = params[:EDUdate]
		@education.mgpa = params[:EDUmgpa]
		@education.gpa = params[:EDUgpa]
		@education.save

		@work = Work.new
		@work.resume_id = @resume.id
		@work.company = params[:WRKcompany]
		@work.position = params[:WRKposition]
		@work.datestart = params[:WRKdatestart]
		@work.dateend = params[:WRKdatend]
		@work.save


			redirect_to @resume

	end

	def destroy
		@resume = Resume.find(params[:id])
		@resume.destroy

		redirect_to resumes_path
	end

	def update
		@resume = Resume.find(params[:id])

		if @resume.update(resume_params)
			redirect_to @resume
		else
			render 'edit'
		end
	end

	private 
		def resume_params
			params.require(:resume).permit(:title,:date, :informationfname, :INFmiddle, :INFlastname, :INFphone, :INFstreet, :INFcity, :INFstate, :INFzip)
			
		end
end

