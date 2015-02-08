class ResumesController < ApplicationController
	def parse
		@parsethis = params[:answer]
		@parsearray = @parsethis.split("*")
		i =0
		while i< @parsearray.length
			if @parsearray[i] == "RES"
				@resume = Resume.new
				@resume.title = @parsearray[i+1]
				@resume.date = @parsearray[i+2]
				@resume.save
				if params[:entity]!=nil && @resume !=nil
					@entry = EntityResume.new
					@entry.resumeid=@resume.id
					@entry.entityid=params[:entity]
					@entry.save
				end
			elsif @parsearray[i] == "INF"
				@information = Information.new
				@information.firstname = @parsearray[i+1]
				@information.middlename = @parsearray[i+2]
				@information.lastname = @parsearray[i+3]
				@information.phone = @parsearray[i+4]
				@information.street = @parsearray[i+5]
				@information.city = @parsearray[i+6]
				@information.state= @parsearray[i+7]
				@information.zipcode = @parsearray[i+8]
				@information.resume_id = @resume.id
				@information.save
			elsif @parsearray[i] == "OBJ"
				@objective = Objective.new
				@objective.position = @parsearray[i+1]
				@objective.date = @parsearray[i+2]
				@objective.fulltime = @parsearray[i+3]
				@objective.resume_id=@resume.id
				@objective.save
			elsif @parsearray[i] == "EDU"
				@education = Education.new
				@education.school = @parsearray[i+1]
				@education.schoolcode = @parsearray[i+2]
				@education.city	= @parsearray[i+3]
				@education.state = @parsearray[i+4]
				@education.degreetype = @parsearray[i+5]
				@education.degree = @parsearray[i+6]
				@education.graddate = @parsearray[i+7]
				@education.mgpa = @parsearray[i+8]
				@education.gpa =@parsearray[i+9]
				@education.resume_id=@resume.id
				@education.save
			elsif @parsearray[i] == "WRK"
				@work = Work.new
				@work.company = @parsearray[i+1]
				@work.position = @parsearray[i+2]
				@work.datestart = @parsearray[i+3]
				@work.dateend = @parsearray[i+4]
				@work.resume_id = @resume.id
				@work.save
			else
			end
					
				
			i+=1
		end
		if params[:entity]!=nil
			redirect_to entity_path(params[:entity])
		else
			redirect_to resumes_path
		end
	end
	def index
		if params[:current] != nil
			@user = User.find(current_user.id)
			@user.resumeid= params[:current]
			@user.save
		end
		@resumes = Resume.where(:userid => current_user.id)
		@resumeliststring=""
		@resumes.each do |x|
			@resumestring = ["*RES",x.title,x.date].join("*")
			@information = Information.find_by(resume_id: x.id)
			if(@information!=nil)
				@infostring = ["*INF",@information.firstname,@information.middlename,@information.lastname,@information.phone,@information.street,@information.city, @information.state,@information.zipcode,].join("*")
			else
				@infostring=""
			end
			@objectivestring=""
			x.objective.each do |x|
				@objectivestring+= ["*OBJ",x.position,x.date,x.fulltime].join("*")
			end
			@educationstring=""
			x.education.each do |x|
				@educationstring+= ["*EDU",x.school,x.schoolcode,x.city,x.state,x.degreetype,x.degree,x.graddate,x.mgpa,x.gpa].join("*")
			end
			@workstring=""
			x.work.each do |x|
				@workstring += ["*WRK",x.company,x.position,x.datestart,x.dateend].join("*")
			end
			@resumeliststring+=@resumestring+@infostring+@objectivestring+@educationstring+@workstring
		end
	end
	def show
		@resume = Resume.find(params[:id])
		@education = Education.find_by(resume_id: @resume.id)
		@information = Information.find_by(resume_id: @resume.id)
		@infostring = ["INF",@information.firstname,@information.middlename,@information.lastname,@information.phone,@information.street,@information.city, @information.state,@information.zipcode].join("*")
		@objectivestring=""
		@resume.objective.each do |x|
			@objectivestring+= ["OBJ",x.position,x.date,x.fulltime].join("*")
		end
		@educationstring=""
		@resume.education.each do |x|
			@educationstring+= ["EDU",x.school,x.schoolcode,x.city,x.state,x.degreetype,x.degree,x.graddate,x.mgpa,x.gpa].join("*")
		end
		@workstring=""
		@resume.work.each do |x|
			@workstring += ["WRK",x.company,x.position,x.datestart,x.dateend].join("*")
		end


	end

	def new
		@resume = Resume.new
		@email = ""
		@phone =""
		@gpa =""
		if params[:email] != nil
			@email = params[:email]
		end
		if params[:phone] != nil
			@phone = params[:phone]
		end
		if params[:gpa] != nil
			@gpa = params[:gpa]
		end
		if params[:firstname] != nil
			@firstname = params[:firstname]
		end
		if params[:lastname] != nil
			@lastname = params[:lastname]
		end
		if params[:degreetype] != nil
			@degreetype = params[:degreetype]
		end
		if params[:city] != nil
			@city = params[:city]
		end
		if params[:degree] != nil
			@degree= params[:degree]
		end
		if params[:state] != nil
			@state = params[:state]
		end
		if params[:zip] != nil
			@zip = params[:zip]
		end

	end

	def edit
		@resume = Resume.find(params[:id])
	end

	def create
		@resume = Resume.new(resume_params)
		@resume.userid = current_user.id
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
		@information.email = params[:INFemail]
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

