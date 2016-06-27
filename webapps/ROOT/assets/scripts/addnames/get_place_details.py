from write_place import write_place

def get_place_details(id,place_lst):
    for place in place_lst:
        xmlid = place['xml:id']
        if xmlid == id[1:]:
            
            
            #checks if the place is a geogFeat and finds geogFeat name         
            geogname = None
            try:
                geog = place.geogName
                try:
                    name = geog.find('name').text                    
                    geogFeat = geog.geogFeat.text                   
                    geogname = name + " " + geogFeat
                except:
                    geogname = geog.text
            except:
                geogname = None
            
            #finds the placename
            try:
                placename = place.placeName.text.strip()
            except:
                placename = None                
            
            #finds the type of place
            try:
                place_type = place.placeName.findChildren()[0].name
            except:
                place_type = None
            
                        
            #finds the location of the place
            try:
                location = place.location.text.strip()                          
            except:
                location = None
                
            #finds the type of location and the id
            try:
                location_type = place.location.findChildren()[0].name
                location_id = place.location.findChildren()[0]['ref'][1:]   
            except:
                location_type = None
                location_id = None

            
            write_place(id,geogname,placename, place_type, location, location_type, location_id)
                    