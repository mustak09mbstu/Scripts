#!/bin/bash

#--------------------------------------------------------------------#
# Script for stopping Pipex Server                                   #
#--------------------------------------------------------------------#

processid_90=`lsof -i :9390 | awk 'NR==2{print $2}'`

echo $processid_90

if [ "$processid_90" != "" ]
then
	kill -9 $processid_90
fi

while true
do
  pipex9390_process_check=`netstat -na | grep :9390`
  if [ "$pipex9390_process_check" = "" ]
  then
          echo "Pipex 9380 is  stopped"
      break
  fi
done
