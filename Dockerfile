FROM nginx:stable

# install software
RUN apt-get update && apt-get install -y openssh-server vim sudo curl	

# create group and user
ARG username=ec2-fake-user
ARG usergroup=ec2-fake-user-group
RUN groupadd $usergroup && useradd -ms /bin/bash -g $usergroup $username

# set default password
ARG userpass=EC2FakeUSer
RUN echo $username:$userpass | chpasswd

# create ssh dirs
RUN mkdir /home/$username/.ssh
RUN echo '' > /home/$username/.ssh/authorized_keys

# add your key here
# COPY id_rsa.pub /home/$username/.ssh/authorized_keys
RUN chown $username:$usergroup /home/$username/.ssh/authorized_keys
RUN chmod 600 /home/$username/.ssh/authorized_keys

# attache a user to the sudo group
RUN usermod -aG sudo $username

# remove pass from sudo
RUN echo '# Sudo execution without a password' >> /etc/sudoers
RUN echo $username 'ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
CMD service ssh start && nginx -g 'daemon off;'

