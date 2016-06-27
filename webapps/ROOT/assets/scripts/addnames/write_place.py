import xml.etree.ElementTree as ET

def create_place_element(place_type,placename,element):
    if place_type == 'district':
        district_element = ET.SubElement(element, 'Section')
        district_element.text = placename
    elif place_type == 'settlement':
        settlement_element = ET.SubElement(element, 'City')
        settlement_element.text = placename
    elif place_type == 'country':
        country_element = ET.SubElement(element, 'Country')
        country_element.text = placename
    elif place_type == 'bloc':
        bloc_element = ET.SubElement(element, 'Continent')
        bloc_element.text = placename
    elif place_type == None:
        area_element = ET.SubElement(element, 'Area')
        area_element.text = placename
    elif place_type == 'region':
        area_element = ET.SubElement(element, 'Province')
        area_element.text = placename
            


def write_place(id,geogname,placename, place_type, location, location_type, location_id):    
    
    geographical_instance = ET.Element('mads')
    geographical_instance.set('id',id[1:])
    
    authority_element = ET.SubElement(geographical_instance, 'authority')   
    
    if location == None:
        geographical_element = ET.SubElement(authority_element, 'geographic')
        if place_type == None:
            if geogname != None:
                geographical_element.text = geogname
            else:
                geographical_element.text = placename
        else:
            create_place_element(place_type,placename,geographical_element)
    else:
        hierachichal_geographic_element = ET.SubElement(authority_element, 'hierachicalGeographic') 
        if geogname != None:
            create_place_element(place_type,geogname,hierachichal_geographic_element)    
        else:                  
            create_place_element(place_type,placename,hierachichal_geographic_element)
        create_place_element(location_type,location,hierachichal_geographic_element)
        
    names_file = '../../authority/names.xml'
    authority_file = ET.parse(names_file)        
    mads_collection = authority_file.getroot()
    mads_collection.append(geographical_instance)
    with open(names_file, 'w') as output:
        output.write(ET.tostring(mads_collection))    
    
        