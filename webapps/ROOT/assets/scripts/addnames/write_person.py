import xml.etree.ElementTree as ET
import clean_date
from bs4 import BeautifulSoup

def write_person(id,uri,rolename,forename,middlename,surname,maiden,married,nickname,birth,death, name):
    name_instance = ET.Element('mads')
    name_instance.set('id',id[1:])
    
    authority_element = ET.SubElement(name_instance, 'authority')
    if uri != None:
		authority_element.set('valueURI',uri)
    name_element = ET.SubElement(authority_element, 'name')
    name_element.set('type','personal')
    
    if name != None:
        default_name = ET.SubElement(name_element, 'namePart')
        default_name.text = name
    else:
    
        if rolename != None:
            term_of_address = ET.SubElement(name_element, 'namePart')
            term_of_address.set('type','termsOfAddress')
            term_of_address.text = rolename
        
        if forename != None:
            given_name = ET.SubElement(name_element, 'namePart')
            given_name.set('type','given')
            given_name_lst = [forename]    
            if middlename != None:
                given_name_lst.append(middlename)
            if nickname != None:
                given_name_lst.append('(aka ' + nickname + ')')
            given_name_string = ' '.join(given_name_lst)   
            given_name.text = given_name_string
        
        if surname != None:        
            family_name = ET.SubElement(name_element, 'namePart')
            family_name.set('type','family')
            family_name.text = surname
        else:    
            if married != None:
                family_name = ET.SubElement(name_element, 'namePart')
                family_name.set('type','family')
                family_name.text = married            
            elif maiden != None:
                family_name = ET.SubElement(name_element, 'namePart')
                family_name.set('type','family')
                family_name.text = married
        
        if birth != None or death != None:
            date = ET.SubElement(name_element, 'namePart')
            date.set('type','date')
            date_lst = []        
            if birth!=None:                 
                date_lst.append(clean_date.clean_date(birth) + '-')
            if death != None:
                date_lst.append('-' + clean_date.clean_date(death))
            date_string = ''.join(date_lst)
            clean_date_string = date_string.replace('--','-')
            date.text = clean_date_string
            
        if maiden != None and surname != maiden:
            refs = ET.SubElement(authority_element, 'refs')
            
            maiden_ref = ET.SubElement(refs, 'ref')
            maiden_ref.set('variantType','maiden')
                
            personal_name_alt = ET.SubElement(maiden_ref,'name')
            personal_name_alt.set('type','personal')
                
            given_name_alt = ET.SubElement(personal_name_alt, 'namePart')
            given_name_alt.set('type','given')
            given_name_alt.text = given_name_string
                
            maiden_name = ET.SubElement(personal_name_alt, 'namePart')
            maiden_name.set('type','family')
            maiden_name.text = maiden        
        
    names_file = '../../authority/names.xml'
    authority_file = ET.parse(names_file)       
    mads_collection = authority_file.getroot()
    mads_collection.append(name_instance)
    with open(names_file, 'w') as output:
        output.write(ET.tostring(mads_collection))

    
    

