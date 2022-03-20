#!/bin/bash
#
#--------------------------------------------------------------------#
# Script for removing war & valme directory from a single tomcate    #
#--------------------------------------------------------------------#
user_name="srvvalmetpdm"
app_server_name="AppServer6"
tomcat_port_number="8686"
suffix="$(date +%Y)-$(date +%m)-$(date +%d)"


printf "Checking tomcat port...$tomcat_port_number\n"
TOMCATPORT=`netstat -na | grep :$tomcat_port_number | awk '{print $6}'`
printf "Tomcat port status : $TOMCATPORT \n"

if [ "$TOMCATPORT" = "" ]; then
     printf "Tomcat port $tomcat_port_number is down.\n"
    
     #Backup EIF log
     cd /apps/tomcat/$user_name/$app_server_name/apache-tomcat-9.0.45/logs/
     tar -czvf  eif_${tomcat_port_number}_${suffix}.tar.gz /apps/tomcat/$user_name/$app_server_name/apache-tomcat-9.0.45/webapps/valmet/eif/
     
     cd /apps/tomcat/$user_name/$app_server_name/apache-tomcat-9.0.45/webapps/

     rm -rf valmet
     printf "Valmet directory has been deleted successfully from $app_server_name.\n"

     rm -rf valmet.war
     printf "war file has been deleted successfully from $app_server_name.\n"

     cd /apps/tomcat/$user_name/testscripts
     ./clear_cache.sh

else
    printf "Tomcat server $tomcat_port_number is up and running. Not removing war and valmet directory. \n\n"
fi

