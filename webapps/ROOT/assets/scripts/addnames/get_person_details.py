import write_person

'''
Finds all the information about a person needed for the authority file
'''    
def get_person_details(id,person_lst):
	for person in person_lst:
		xmlid = person['xml:id']                
		if xmlid == id[1:]:
                    
			#finds URI
			try:
				uri = person['source']
			except:
				uri = None
			
			#finds the forename of the person
			try:
				forename = person.forename.text
			except:
				forename = None
                   
			#finds the middlename of the person
			try:
				middlename = person.find(type='middle').text
			except:
				middlename = None
                    
			#finds the nickname of the person
			try:
				nickname = person.find(type='nickname').text
			except:
				nickname = None
                    
			#finds the surname of the person
			try:
				maiden = person.find(type='maiden').text
			except:
				maiden = None
			try:
				married = person.find(type='married').text
			except:
				married = None   
            
			surname = None
			if maiden == None or married == None:
				try:
					surname = person.surname.text
				except:
					surname = None
                    
			#finds rolename of the person
			try:
				rolename = person.rolename
				type = rolename['type']
				rolename = rolename.text                        
			except:
				rolename = None
                    
			#finds birth of the person
			try:
				birth = person.birth
				birth = birth['when']
			except:
				birth = None
                    
			#finds death of the person
			try:
				death = person.death
				death = death['when']
			except:
				death = None
			name = None
			if forename == None and surname == None:
				name = person.text
			write_person.write_person(id,uri,rolename,forename,middlename,surname,maiden,married,nickname,birth,death,name)