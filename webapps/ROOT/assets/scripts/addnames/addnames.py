from bs4 import BeautifulSoup
import os, shutil
import get_person_details, get_place_details
import write_person
import xml.etree.ElementTree as ET
import unicodedata

#gets current directory
current_directory = os.getcwd()

#saves location of tei_in, tei_out, and names file folders
names_file = '../../authority/names.xml'
tei_in = current_directory + '/TEI_IN'
tei_out = current_directory + '/TEI_OUT'

#opens authority_file and parses
authority_xml = BeautifulSoup(open(names_file))

names_in_authority_file = []
names_without_type_or_id = []

#gets list of files in tei_in
files = os.listdir(tei_in) 
'''
Gets list of ids currently in authority file
'''
def check_authority_file():
    authority_xml = BeautifulSoup(open(names_file))    
    names = authority_xml.findAll('mads')
    for name in names:        
        names_in_authority_file.append(name['id'])
        
   
'''
Function that checks to see if the name is in the authority file
'''
def check_authority(place_lst,person_lst, id, type):   
    if id[1:] in names_in_authority_file:
        pass
    else:
        if type == 'person':
            names_in_authority_file.append(id[1:])
            get_person_details.get_person_details(id,person_lst)
        elif type == 'place':
           names_in_authority_file.append(id[1:])
           get_place_details.get_place_details(id,place_lst)        
        else:
            print (id + "'s type, '" + type + "' is not a valid type")

'''
Function which draws people, places, and organisations out of the tei
file and finds their type + id
'''
def processTEIFile():
	#loops through files in the files list
	for file in files:        
		check_authority_file()
        
		#uses the beautifulsoup library to read the xml file
		file_directory = tei_in + "/" + file
		xml = BeautifulSoup(open(file_directory),'xml')
		print ('Processing ' + file)
    
		#finds the list of places in the teiheader
		place_lst = xml.findAll('place')
        
        
		#finds the list of people in the teiheader
		person_lst = xml.findAll('person')
		
		#finds all names in the file  
		names = xml.find_all('name')        
              
		#loops through names in the file
		for name in names:
        
			#list of elements in header that contain name element
			header_name_nodes = ['author','principal','respStmt','change', 'geogName']        
			#gives the name of the attribute that contains the 'name' attribute
			parent_node = name.parent.name
			#checks to make sure that the 'name' attribute is not in any of the header attributes
			if parent_node not in header_name_nodes:            
                
				#finds the value of the name's type attribute (returns a message if they type does not exist)
				try:
					type = name['type']
				except:                
					type= None
					if name.text not in names_without_type_or_id:                        
						names_without_type_or_id.append(name)                        
                
				#finds the value of the name's id attribute (returns a message if they type does not exist)
				try:                
					id = name['ref']
				except:                
					id = None
					if name.text not in names_without_type_or_id:
						names_without_type_or_id.append(name.text)
                
				#skips name id or type are missing
				if type != None and id !=None:                    
					check_authority(place_lst,person_lst, id, type)        
		
		print ("")
		print ('Processing of ' + file + ' complete')
		print ("")
		file_out = tei_out + "/" + file
		shutil.move(file_directory,file_out)
                
processTEIFile()
for id in names_without_type_or_id:
    try:
        print ("Warning: " + id.text + " has been skipped as they do not have either a type or id attribute")
    except:
        print "Warning " + id.encode('utf-8') + " has been skipped as they do not have either a type or id attribute"
