months = {'01':'January','02':'Feburary','03':'March','04':'April','05':'May','06':'June','07':'July','08':'August','09':'September','10':'October','11':'November','12':'December'}


def clean_date(date):
    day = ''
    if date[8:9] == '0':
        day = date[9:10]
    else:
        day = date[8:10]
        
    month = date[5:7]    
    new_month = months[month]
    
    year = date[:4]
    
    return day + ' ' + new_month + ' ' + year 