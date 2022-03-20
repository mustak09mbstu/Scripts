#!/bin/bash

pipex_9390="pipex2_9390"
jetty_9390="jetty-distribution-9.4.31.v20200723"

cd /apps/$pipex_9390/$jetty_9390/bin

./checksum compute
./pipex restart
