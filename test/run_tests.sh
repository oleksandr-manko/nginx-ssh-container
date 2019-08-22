#!/bin/bash

echo -e "\n" current user and path info
echo user ==> $(whoami); path ==> $(pwd)
echo "[OK]"

echo -e "\n" started scaning 10.1.0.1/24 network
nmap 10.1.0.1/24
echo "[OK]"

echo -e "\n" started scaning expected host 10.1.0.5
nmap 10.1.0.5
echo "[OK]"

echo -e "\n" started ssh connection to the expected host via ssh
USERNAME=$(sshpass -p EC2FakeUSer ssh -o StrictHostKeyChecking=no ec2-fake-user@10.1.0.5 whoami)

if [ "$USERNAME" != "ec2-fake-user" ] 
then
    exit 1
else
    echo "[OK]"
fi