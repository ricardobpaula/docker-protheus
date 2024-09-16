FROM mcr.microsoft.com/mssql/server:2022-latest

COPY ./setup.sql /setup.sql 
COPY ./entrypoint.sh /entrypoint.sh 
COPY ./run-initialization.sh /run-initialization.sh 

ENTRYPOINT [ "/bin/bash", "/entrypoint.sh" ]