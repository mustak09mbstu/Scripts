#!/bin/bash
#
#--------------------------------------------------------------------#
# Script for copying war  files in given Appserver                   #
#--------------------------------------------------------------------#

app_server_name="AppServer6"
tomcat_version="apache-tomcat-9.0.45"
warlocation="/apps/tomcat/srvtest/automation"
cp -r $warlocation/test.war  /apps/tomcat/srvtest/$app_server_name/$tomcat_version/webapps

echo "War has been copied successfully"

