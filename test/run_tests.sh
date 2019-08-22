#!/bin/bash

echo user ==> $(whoami)
echo path ==> $(pwd)

echo started scaning 10.1.0.1/24 network
nmap 10.1.0.1/24

echo started scaning expected host 10.1.0.5
nmap 10.1.0.5

echo started ssh connection to the expected host via ssh 
sshpass -p EC2FakeUSer ssh ec2-fake-user@10.1.0.5

echo user ==> $(whoami)
echo path ==> $(pwd)

exit
