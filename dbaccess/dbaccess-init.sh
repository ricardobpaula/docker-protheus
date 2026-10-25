#!/bin/sh
set -e

/bin/sed 's/{{DB_USER}}/'"${DB_USER}"'/' -i /etc/odbc.ini
/bin/sed 's/{{DB_PASS}}/'"${DB_PASS}"'/' -i /etc/odbc.ini
/bin/sed 's/{{DB_HOST}}/'"${DB_HOST}"'/' -i /etc/odbc.ini
/bin/sed 's/{{DB_PORT}}/'"${DB_PORT}"'/' -i /etc/odbc.ini
/bin/sed 's/{{DB_NAME}}/'"${DB_NAME}"'/' -i /etc/odbc.ini

/opt/totvs/dbaccess/tools/dbaccesscfg \
  -u ${DB_USER} \
  -p ${DB_PASS} \
  -d ${DB_TYPE} \
  -a ${DB_NAME} \
  -o "clientlibrary=/usr/lib64/libodbc.so" \
  -g "LicenseServer=${LICENSE_SERVER};LicensePort=5555;ByYouProc=0;ODBC30=1"

exec "/opt/totvs/dbaccess/multi/dbaccess64"