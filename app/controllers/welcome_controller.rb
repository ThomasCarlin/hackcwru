class WelcomeController < ApplicationController
  def index
  end

  def upload
  	file = params[:file]
		f = file.open
		@lines=""
		@phone=""
		@zip=""
		@gpa=""
		@mgpa=""
		@firstname=""
		@lastname=""
		@degreetype=""
		f.each_line do |line|
			if line.include? '@'
				line.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
.split(' ').each do |x|
					if x.include? '@'
						@lines=x
					end
				end
			end

			if line.include? '-'
				line.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
.split(' ').each do |x|
					if x[/\d/] != nil
						if x.scan(/\d/).length > 5
							@phone=x
						else
							@zip=x
						end
					end
				end
			end

			if line.include? "GPA"
				line.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
.split(' ').each do |x|
					if x[/\d/] != nil
						if x.scan(/\d/).length >1
							@gpa=""
							x.each_char do |c|
								if c[/\d/] != nil || (c =='.')
									@gpa+=c
								end
							end
						end
					end
				end
			end

			if line.include? "GPA"
				if line.include? "MAJOR"
					line.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
	.split(' ').each do |x|
						if x[/\d/] != nil
							if x.scan(/\d/).length >1
								@mgpa=""
								x.each_char do |c|
									if c[/\d/] != nil || (c =='.')
										@mgpa+=c
									end
								end
							end
						end
					end
				end
			end

			@names = ['Michael','James','John','Robert','David','William','Mary','Christopher','Joseph','Richard','Daniel','Thomas','Matthew','Jennifer','Charles','Anthony','Patricia','Linda','Mark','Elizabeth','Joshua','Steven','Andrew','Kevin','Brian','Barbara','Jessica','Jason','Susan','Timothy','Paul','Kenneth','Lisa','Ryan','Sarah','Karen','Jeffrey','Donald','Ashley','Eric','Jacob','Nicholas','Jonathan','Ronald','Michelle','Kimberly','Nancy','Justin','Sandra','Amanda','Brandon','Stephanie','Emily','Melissa','Gary','Edward','Stephen','Scott','George','Donna','Jose','Rebecca','Deborah','Laura','Cynthia','Carol','Amy','Margaret','Gregory','Sharon','Larry','Angela','Maria','Alexander','Benjamin','Nicole','Kathleen','Patrick','Samantha','Tyler','Samuel','Betty','Brenda','Pamela','Aaron','Kelly','Heather','Rachel','Adam','Christine','Zachary','Debra','Katherine','Dennis','Nathan','Christina','Julie','Jordan','Kyle','Anna','']
			@lastnames =['Smith','Johnson','Williams','Brown','Jones','Garcia','Rodriguez','Miller','Martinez','Davis','Hernandez','Lopez','Gonzalez','Wilson','Anderson','Thomas','Taylor','Lee','Moore','Jackson','Perez','Martin','Thompson','White','Sanchez','Harris','Ramirez','Clark','Lewis','Robinson','Walker','Young','Hall','Allen','Torres','Nguyen','Wright','Flores','King','Scott','Rivera','Green','Hill','Adams','Baker','Nelson','Mitchell','Campbell','Gomez','Carter','Roberts','Diaz','Phillips','Evans','Turner','Reyes','Cruz','Parker','Edwards','Collins','Stewart','Morris','Morales','Ortiz','Gutierrez','Murphy','Rogers','Cook','Kim','Morgan','Cooper','Ramos','Peterson','Gonzales','Bell','Reed','Bailey','Chavez','Kelly','Howard','Richardson','Ward','Cox','Ruiz','Brooks','Watson','Wood','James','Mendoza','Gray','Bennett','Alvarez','Castillo','Price','Hughes','Vasquez','Sanders','Jimenez','Long','Foster','']

			@degrees =['BS','B.S.','M.S.','MS','PhD']

			line.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
	.split(' ').each do |x|
				if @names.include?(x)
					@firstname= x
				end
			end

			line.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
	.split(' ').each do |x|
				if @lastnames.include?(x)
					@lastname= x
				end
			end

			line.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
	.split(' ').each do |x|
				if @lastnames.include?(x)
					@degreetype= x
				end
			end

		end
		@lines=@lines.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
		f.close
		redirect_to new_resume_path(email: @lines, phone: @phone, zip:@zip, gpa:@gpa, mgpa:@mgpa, firstname:@firstname, lastname:@lastname, degreetype:@degreetype)
  end

	def letter?(lookAhead)
	  lookAhead =~ /[[:alpha:]]/
	end

	def numeric?(lookAhead)
	  lookAhead =~ /[[:digit:]]/
	end
end
