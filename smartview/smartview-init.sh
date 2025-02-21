#!/bin/bash
# Use a variável de ambiente PORT
exec /usr/sbin/smart-view/TReports.Agent --urls "http://*:${SMARTVIEW_PORT}"