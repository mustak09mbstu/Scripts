#!/bin/bash
#
#--------------------------------------------------------------------#
# Script for removing cache files in given Appserver                 #
#--------------------------------------------------------------------#

app_server_name="AppServer6"
tomcat_version="apache-tomcat-9.0.45"
cd /apps/tomcat/srvvalmetpdm/$app_server_name/$tomcat_version/work/Catalina/
rm -rf localhost
printf "All cache files have been deleted successfully from $app_server_name.\n\n"

