import sys
from typing_extensions import Self
import pyodbc as odbc
from datetime import datetime

current_time= datetime.now()
# curr_time=current_time.strftime("%d-%m-%Y %H:%M:%S")
jsondata={"licensenumber":"KA05AJ9678","placename":"DU3","timeslot":current_time,"filepath":"D:/rohan/Documents/License_detection/Backend/images/L_crop29.jpg"}
print(type(jsondata))
print(jsondata["licensenumber"])
records = [[jsondata["licensenumber"],jsondata["timeslot"],jsondata["licensenumber"],jsondata["licensenumber"],jsondata["licensenumber"],jsondata["licensenumber"],jsondata["placename"],jsondata["timeslot"],jsondata["filepath"],jsondata["licensenumber"],jsondata["timeslot"]]]

try:
    conn = odbc.connect('Driver={SQL Server};''Server=ROHANDELL\SQLEXPRESS;''Database=license;''Trusted_Connection=yes;')
    print("connection successful")
except Exception as e:
    print(e)
    print('task is terminated')
    sys.exit()
else:
    cursor = conn.cursor()


insert_statement ='''DECLARE @timedif int 
set @timedif = DATEDIFF( MINUTE, (SELECT MAX(timeslot) FROM license_master WHERE licensenumber=?), ?);
If not exists(SELECT * FROM license_master t1 WHERE t1.timeslot = (SELECT MAX(timeslot) 
FROM license_master t2 WHERE t2.licensenumber=? and t2.datedifference>@timedif+(SELECT datedifference 
FROM license_master t3 WHERE t3.licensenumber=? and t3.timeslot=(SELECT MAX(timeslot) 
FROM license_master t4 WHERE t4.licensenumber=?))-2))
INSERT INTO license_master (licensenumber,placename,timeslot, filepath, datedifference) 
VALUES (?, ?, ?, ?,ISNULL(DATEDIFF( Minute, (SELECT MAX(timeslot) FROM license_master s2 WHERE s2.licensenumber=?),?),0));
'''

#first statement
try:
    for record in records:
        print(records)
        cursor.execute(insert_statement, record)        
except Exception as e:
    cursor.rollback()
    print(e)
    print('transaction rolled back')
else:
    print('records inserted successfully')
    cursor.commit()
    cursor.close()
    conn.close()