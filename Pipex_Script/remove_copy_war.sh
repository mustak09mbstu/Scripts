#!/bin/bash

pipex_9390="pipex2_9390"
jetty_9390="jetty-distribution-9.4.31.v20200723"

cd /apps/$pipex_9390/$jetty_9390/webapps

rm -fr pipex2.war
rm -fr ../work/*

cp -r /apps/automation/pipex2.war .


