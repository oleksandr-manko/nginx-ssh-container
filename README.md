# nginx-ssh-docker-file
This docker file creates preconfigured ssh server with a user that is in sudoers group. A user is able to execute sudo commands without a password. The image is based on nginx.

# Build image process
### build the Docker file and create an image
```console
$ docker build -t nginx-ssh https://github.com/oleksandr-manko/nginx-ssh-docker-file.git
```

### run the image
```console
$ docker run -d -p 23:22 -p 8080:80 --name nginx-ssh-container nginx-ssh
```

### connect to the container from the parent machine
The password is `EC2FakeUSer`
```console
$ docker exec -ti nginx-ssh-container /bin/bash
```
# Keys passing process
### insert specific pub key to the container on the remoute machine via ssh
```console
sudo ssh-copy-id -p 23 -i ~/.ssh/id_rsa ec2-fake-user@parent-machine-ip
```

# Connectivity
### connect to the remout docker container from the parent machine via ssh
```console
$ ssh ec2-fake-user@localhost -p 23
```

### connect to the remout docker container from any external machine via ssh
```console
$ ssh ec2-user@parent-machine-ip -p 23
```
# Turning off the password based authentication
1) open
```console
sudo vim /etc/ssh/sshd_config
```

2) set the following properties 
```console
ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no
```

3) restart ssh service
```console
sudo service ssh restart
```
