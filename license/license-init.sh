#!/bin/bash
cp /totvs/totvslicensevirtual/licenseserver_bkp.ini /totvs/totvslicensevirtual/bin/appserver/licenseserver.ini

exec /totvs/totvslicensevirtual/bin/appserver/appsrvlinux
