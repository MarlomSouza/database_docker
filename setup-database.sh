echo 'Please wait while SQL Server 2017 warms up'
sleep 15s &&
echo 'Initializing database after 10 seconds of wait'
../opt/mssql-tools/bin/sqlcmd -S 127.0.0.1 -U sa -P Sa.123456 -Q "create database agehab_inscricao"
echo 'Finished initializing the database'