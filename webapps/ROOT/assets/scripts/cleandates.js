function clean_dates(dates){
            for (i=0; i<dates.length; i++){
                var date = dates[i].innerHTML;
                var year = date.slice(0,4);
                var month = date.slice(5,7);
                var day = date.slice(8,10);
                
                var month_string = get_string(month);
                
                var date_string = day + " " + month_string + " " + year;
                dates[i].innerHTML = date_string;
           } 
} 

function get_string(month){
                    if (month === '01')
                        {
                        return 'January';
                        }                        
                    else if (month === '02')
                        {
                            return 'February';
                        }
                    else if (month == '03')
                        {
                            return 'March';
                        }
                    else if (month == '04')
                        {
                            return 'April';
                        }
                    else if (month == '05')
                        {
                            return 'May';
                        }
                    else if (month == '06')
                        {
                            return 'June';
                        }
                    else if (month == '07')
                        {
                            return 'July';
                        }
                    else if (month == '08')
                        {
                            return 'August';
                        }
                    else if (month == '09')
                        {
                            return 'September';
                        }
                    else if (month == '10')
                        {
                            return 'October';
                        }
                    else if (month == '11')
                        {
                            return 'November';
                        }
                    else if (month == '12')
                        {
                            return 'December';
                        }
}                        

