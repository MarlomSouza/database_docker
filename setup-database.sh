echo 'Please wait while SQL Server 2017 warms up'
timeout 10

echo 'Initializing database after 10 seconds of wait'
/opt/mssql-tools/bin/sqlcmd -S 127.0.0.1 -U sa -P Sa.123456 -i criar_banco.sql 

echo 'Finished initializing the database'