# Stop tomcat server

echo "Change directory to /apps/tomcat/srvtest/AppServer6/apache-tomcat-9.0.45/bin"

cd "/apps/tomcat/srvtest/AppServer6/apache-tomcat-9.0.45/bin/"

echo "Executing shutdown.sh file......."

./shutdown.sh


while true
do
  TOMCATPORT=`netstat -na | grep :8686 | awk '{print $6}'`
  if [ "$TOMCATPORT" = "" ]
  then 
	  echo "Tomcat Server 6(Version 9) stoped successfully."
      break
  fi
done

/sbin/fuser -k 9012/tcp

