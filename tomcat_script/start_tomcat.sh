echo "Change directory to /apps/tomcat/srvtest/AppServer6/apache-tomcat-9.0.45/bin/"

cd "/apps/tomcat/srvtest/AppServer6/apache-tomcat-9.0.45/bin/"

echo "Executing startServer.sh file......."

export NLS_LANG=AMERICAN_AMERICA.UTF8

./startup.sh

while true
do
 TOMCAT=`netstat -na | grep :8686 | awk '{print $6}' | wc -l`
 if [ "$TOMCAT" != 0 ]
 then
	 echo "Tomcat Server 6 (Version 9) started successfully"
	 echo "Tomcat Server 6 (Version 9) listening port 8686"
     break
  fi
done


