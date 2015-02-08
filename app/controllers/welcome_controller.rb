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
		@degree=""
		@city=""
		@state=""
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

			@cities =['Aberdeen','Abilene','Akron','Albany','Albuquerque','Alexandria','Allentown','Amarillo','Anaheim','Anchorage','Ann Arbor','Antioch','Apple Valley','Appleton','Arlington','Arvada','Asheville','Athens','Atlanta','Atlantic City','Augusta','Aurora','Austin','Bakersfield','Baltimore','Barnstable','Baton Rouge','Beaumont','Bel Air','Bellevue','Berkeley','Bethlehem','Billings','Birmingham','Bloomington','Boise','Boise City','Bonita Springs','Boston','Boulder','Bradenton','Bremerton','Bridgeport','Brighton','Brownsville','Bryan','Buffalo','Burbank','Burlington','Cambridge','Canton','Cape Coral','Carrollton','Cary','Cathedral City','Cedar Rapids','Champaign','Chandler','Charleston','Charlotte','Chattanooga','Chesapeake','Chicago','Chula Vista','Cincinnati','Clarke County','Clarksville','Clearwater','Cleveland','College Station','Colorado Springs','Columbia','Columbus','Concord','Coral Springs','Corona','Corpus Christi','Costa Mesa','Dallas','Daly City','Danbury','Davenport','Davidson County','Dayton','Daytona Beach','Deltona','Denton','Denver','Des Moines','Detroit','Downey','Duluth','Durham','El Monte','El Paso','Elizabeth','Elk Grove','Elkhart','Erie','Escondido','Eugene','Evansville','Fairfield','Fargo','Fayetteville','Fitchburg','Flint','Fontana','Fort Collins','Fort Lauderdale','Fort Smith','Fort Walton Beach','Fort Wayne','Fort Worth','Frederick','Fremont','Fresno','Fullerton','Gainesville','Garden Grove','Garland','Gastonia','Gilbert','Glendale','Grand Prairie','Grand Rapids','Grayslake','Green Bay','GreenBay','Greensboro','Greenville','Gulfport-Biloxi','Hagerstown','Hampton','Harlingen','Harrisburg','Hartford','Havre de Grace','Hayward','Hemet','Henderson','Hesperia','Hialeah','Hickory','High Point','Hollywood','Honolulu','Houma','Houston','Howell','Huntington','Huntington Beach','Huntsville','Independence','Indianapolis','Inglewood','Irvine','Irving','Jackson','Jacksonville','Jefferson','Jersey City','Johnson City','Joliet','Kailua','Kalamazoo','Kaneohe','Kansas City','Kennewick','Kenosha','Killeen','Kissimmee','Knoxville','Lacey','Lafayette','Lake Charles','Lakeland','Lakewood','Lancaster','Lansing','Laredo','Las Cruces','Las Vegas','Layton','Leominster','Lewisville','Lexington','Lincoln','Little Rock','Long Beach','Lorain','Los Angeles','Louisville','Lowell','Lubbock','Macon','Madison','Manchester','Marina','Marysville','McAllen','McHenry','Medford','Melbourne','Memphis','Merced','Mesa','Mesquite','Miami','Milwaukee','Minneapolis','Miramar','Mission Viejo','Mobile','Modesto','Monroe','Monterey','Montgomery','Moreno Valley','Murfreesboro','Murrieta','Muskegon','Myrtle Beach','Naperville','Naples','Nashua','Nashville','New Bedford','New Haven','New London','New Orleans','New York','New York City','Newark','Newburgh','Newport News','Norfolk','Normal','Norman','North Charleston','North Las Vegas','North Port','Norwalk','Norwich','Oakland','Ocala','Oceanside','Odessa','Ogden','Oklahoma City','Olathe','Olympia','Omaha','Ontario','Orange','Orem','Orlando','Overland Park','Oxnard','Palm Bay','Palm Springs','Palmdale','Panama City','Pasadena','Paterson','Pembroke Pines','Pensacola','Peoria','Philadelphia','Phoenix','Pittsburgh','Plano','Pomona','Pompano Beach','Port Arthur','Port Orange','Port Saint Lucie','Port St. Lucie','Portland','Portsmouth','Poughkeepsie','Providence','Provo','Pueblo','Punta Gorda','Racine','Raleigh','Rancho Cucamonga','Reading','Redding','Reno','Richland','Richmond','Richmond County','Riverside','Roanoke','Rochester','Rockford','Roseville','Round Lake Beach','Sacramento','Saginaw','Saint Louis','Saint Paul','Saint Petersburg','Salem','Salinas','Salt Lake City','San Antonio','San Bernardino','San Buenaventura','San Diego','San Francisco','San Jose','Santa Ana','Santa Barbara','Santa Clara','Santa Clarita','Santa Cruz','Santa Maria','Santa Rosa','Sarasota','Savannah','Scottsdale','Scranton','Seaside','Seattle','Sebastian','Shreveport','Simi Valley','Sioux City','Sioux Falls','South Bend','South Lyon','Spartanburg','Spokane','Springdale','Springfield','St. Louis','St. Paul','St. Petersburg','Stamford','Sterling Heights','Stockton','Sunnyvale','Syracuse','Tacoma','Tallahassee','Tampa','Temecula','Tempe','Thornton','Thousand Oaks','Toledo','Topeka','Torrance','Trenton','Tucson','Tulsa','Tuscaloosa','Tyler','Utica','Vallejo','Vancouver','Vero Beach','Victorville','Virginia Beach','Visalia','Waco','Warren','Washington','Waterbury','Waterloo','West Covina','West Valley City','Westminster','Wichita','Wilmington','Winston','Winter Haven','Worcester','Yakima','Yonkers','York','Youngstown']

			@states=['AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'GA', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MI', 'MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VA', 'VT', 'WA', 'WI', 'WV', 'WY']

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
	.split(' ').each_with_index do |x,index|
				if @degrees.include?(x)
					@degreetype= x
					@degree=line.split(' ')[index+1]
				end
			end

			line.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
	.split(' ').each do |x|
				if @cities.include?(x)
					@city= x
				end
			end
			line.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
	.split(' ').each do |x|
				if @states.include?(x)
					@state= x
				end
			end
			line.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
	.split(' ').each do |x|
				if x[/\d/] != nil
					if x.scan(/\d/).length >4 && x.length < 6
						@zip= x
					end
				end
			end

		end
		@lines=@lines.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
		f.close
		redirect_to new_resume_path(email: @lines, phone: @phone, zip:@zip, gpa:@gpa, mgpa:@mgpa, firstname:@firstname, lastname:@lastname, degreetype:@degreetype, city:@city, degree:@degree, state:@state)
  end

	def letter?(lookAhead)
	  lookAhead =~ /[[:alpha:]]/
	end

	def numeric?(lookAhead)
	  lookAhead =~ /[[:digit:]]/
	end
end
