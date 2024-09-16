#!/bin/bash

# Wait 60 seconds for SQL Server to start up by ensuring that 
# calling SQLCMD does not return an error code, which will ensure that sqlcmd is accessible
# and that system and user databases return "0" which means all databases are in an "online" state
# https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-databases-transact-sql?view=sql-server-2017 

DBSTATUS=1
ERRCODE=1
i=0

while [[ $DBSTATUS -ne 0 ]] && [[ $i -lt 60 ]] && [[ $ERRCODE -ne 0 ]]; do
	i=$i+1
	DBSTATUS=$(/opt/mssql-tools18/bin/sqlcmd -h -1 -t 1 -U sa -P $MSSQL_SA_PASSWORD -Q "SET NOCOUNT ON; Select SUM(state) from sys.databases" -C)
	ERRCODE=$?
	sleep 1
done

# Run the setup script to create the DB and the schema in the DB
echo "password"
echo $MSSQL_SA_PASSWORD
/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P $MSSQL_SA_PASSWORD -d master -i setup.sql -C