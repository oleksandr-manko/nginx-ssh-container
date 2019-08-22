#!/bin/bash

echo "\ncurrent user and path info"
echo user ==> $(whoami)
echo path ==> $(pwd)
echo "[OK]"

echo "\nstarted scaning 10.1.0.1/24 network"
nmap 10.1.0.1/24
echo "[OK]"

echo "\nstarted scaning expected host 10.1.0.5"
nmap 10.1.0.5
echo "[OK]"

echo "\nstarted ssh connection to the expected host via ssh"
USERNAME=$(sshpass -p EC2FakeUSer ssh -o StrictHostKeyChecking=no ec2-fake-user@10.1.0.5 whoami)

if [ "$USERNAME" != "ec2-fake-user" ] 
then
    exit 1
else
    echo "[OK]\n"
fi