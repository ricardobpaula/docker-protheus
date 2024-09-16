#!/bin/sh
set -e

/bin/sed 's/{{DBACCESS_SERVER}}/'"${DBACCESS_SERVER}"'/' -i /opt/totvs/appserver/appserver.ini
/bin/sed 's/{{DBACCESS_ALIAS}}/'"${DBACCESS_ALIAS}"'/' -i /opt/totvs/appserver/appserver.ini
/bin/sed 's/{{DBACCESS_PORT}}/'"${DBACCESS_PORT}"'/' -i /opt/totvs/appserver/appserver.ini
/bin/sed 's/{{LICENSE_SERVER}}/'"${LICENSE_SERVER}"'/' -i /opt/totvs/appserver/appserver.ini

exec "/opt/totvs/appserver/appsrvlinux"