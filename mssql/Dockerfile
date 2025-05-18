FROM mcr.microsoft.com/mssql/server:2022-latest

HEALTHCHECK --interval=10s --timeout=3s --start-period=10s --retries=10 \
    CMD sqlcmd -S localhost -U sa -P ${SA_PASSWORD} -Q "SELECT 1" || exit 1

COPY ./setup.sql /setup.sql 
COPY ./entrypoint.sh /entrypoint.sh 
COPY ./run-initialization.sh /run-initialization.sh

ENTRYPOINT [ "/bin/bash", "/entrypoint.sh" ]