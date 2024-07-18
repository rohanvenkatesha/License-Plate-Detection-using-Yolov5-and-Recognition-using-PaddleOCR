import sys
#from urllib import request
import pyodbc as odbc
from flask import Flask, render_template, request, session

app = Flask(__name__)
@app.route("/", methods=['POST','GET'])
def table():
    try:
        conn = odbc.connect('Driver={SQL Server};''Server=ROHANDELL\SQLEXPRESS;''Database=license;''Trusted_Connection=yes;')
        print("connection successful")
    except Exception as e:
        print(e)
        print('task is terminated')
        sys.exit()
    else:
        cursor = conn.cursor()
    licno= request.form.get("licno")
    license_master_data=[]
    license_master_data_tuple=()
    cursor.execute("Select * from license_master order by timeslot asc")

    for row in cursor:
        license_master_data.append(row)
    # print(license_master_data[0])
    license_master_data_tuple=tuple(license_master_data)
    cursor.close()

    license_count_data=[]
    license_count_data_tuple=()
    cursor = conn.cursor()
    cursor.execute("Select * from license_count order by timeslot asc")

    for row in cursor:
        license_count_data.append(row)
    #print(license_count_data[0])
    license_count_data_tuple=tuple(license_count_data)
    cursor.close()
    cursor = conn.cursor()

    license_master_search=[]
    license_master_search_tuple=()
    cursor.execute("Select * from license_count where licensenumber=? order by timeslot asc", licno)

    for row in cursor:
        license_master_search.append(row)
    # print(license_master_data[0])
    license_master_search_tuple=tuple(license_master_search)
    cursor.close()

    conn.close()

    # print(license_master_data_tuple)

    headings = ("License number", "Place name","Timeslot","Filepath")
    headings2 = ("License number", "Place name","Count","Timeslot","Filepath")
   # headingsearch = ("License number", "Place name","Timeslot")

    return render_template("index.html" , heading=headings, datalicense=license_master_data_tuple, heading1=headings2, datacount=license_count_data_tuple, headingsearch1=headings2, searchdata=license_master_search_tuple)
if __name__ == "__main__":
    app.run()