#!/bin/bash
#
#--------------------------------------------------------------------#
# Script for copying war  files in given Appserver                   #
#--------------------------------------------------------------------#

app_server_name="AppServer6"
tomcat_version="apache-tomcat-9.0.45"
warlocation="/apps/tomcat/srvvalmetpdm/automation"
cp -r $warlocation/valmet.war  /apps/tomcat/srvvalmetpdm/$app_server_name/$tomcat_version/webapps

echo "War has been copied successfully"

