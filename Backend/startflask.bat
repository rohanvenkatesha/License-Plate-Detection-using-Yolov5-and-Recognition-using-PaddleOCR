NET STOP MSSQL$SQLEXPRESS
NET START MSSQL$SQLEXPRESS
echo "service started successfully"
cd "W:\Project\License_detection-main\License_detection-main\Backend"
set FLASK_APP=readdb.py
set FLASK_ENV=development
flask run