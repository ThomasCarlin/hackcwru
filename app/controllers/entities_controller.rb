class EntitiesController < ApplicationController
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

		redirect_to resumes_path
	end
	def entry
		@resumeid = params[:resumeid]
		@resume = Resume.find(@resumeid)
		@entity = Entity.find(params[:entityid])
		@submission = EntityResume.new
		resumeint=params[:resumeid]
		entityint=params[:entityid]
		@submission.resumeid = resumeint
		@submission.entityid = entityint
		@submission.save

		redirect_to entity_path(@entity)

	end
	def index
		@entities = Entity.all
	end
	def new
		@entity = Entity.new
	end
	def create
		@entity = Entity.new(entity_params)
		@entity.save
		redirect_to @entity
	end

	def show
		@resumelist= Array.new
		@entity= Entity.find(params[:id])
		@entries = EntityResume.where(:entityid => params[:id])
		@entries.each do |x|
			@resume = Resume.find(x.resumeid)
			@resumelist.push(@resume)
		end
		@resumeliststring=""
		@resumelist.each do |x|
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

	private
	def entity_params
		params.require(:entity).permit(:name, :description,:degree,:major,:position,:website,:pic,:resumeid,:entityid)
	end
end