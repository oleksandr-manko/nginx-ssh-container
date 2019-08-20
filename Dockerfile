FROM nginx:stable

# install SSHd
RUN apt-get update && apt-get install -y openssh-server

# create group and user
ARG username=ec2-fake-user
ARG usergroup=ec2-fake-user-group
RUN groupadd $usergroup && useradd -ms /bin/bash -g $usergroup $username

# set default password
ARG userpass=EC2FakeUSer
RUN echo $username:$userpass | chpasswd

# create ssh dirs
RUN mkdir /home/$username/.ssh
RUN mkdir /home/$username/.ssh/authorized_keys

# add your key here
# COPY id_rsa.pub /home/$username/.ssh/authorized_keys
RUN chown $username:$usergroup /home/$username/.ssh/authorized_keys
RUN chmod 600 /home/$username/.ssh/authorized_keys

CMD service ssh start && nginx -g 'daemon off;'

