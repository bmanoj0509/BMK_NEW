Version 1 -> This one will only specify qa server image building and conatiner launching 

FROM ubuntu:latest
RUN /usr/bin/apt-get update -y
RUN /usr/bin/apt-get install -y apt-utils
RUN /usr/bin/apt-get install -y iputils-ping
RUN /usr/bin/apt-get install -y net-tools
RUN /usr/bin/apt-get install -y default-jdk
RUN /usr/bin/apt-get install -y tar
RUN /usr/bin/apt-get install -y wget
RUN cd /tmp
RUN /usr/bin/wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.39/bin/apache-tomcat-9.0.39.tar.gz
RUN mkdir /opt/tomcat
RUN tar xf apache-tomcat-9.0.39.tar.gz -C /opt/tomcat --strip-components=1
RUN useradd tomcat
RUN chgrp -R tomcat /opt/tomcat
RUN chmod -R g=x+r /opt/tomcat
RUN rm -f /opt/tomcat/tomcat-users.xml
ADD https://github.com/bmanoj0509/BMK/blob/master/tomcat9-users.xml /opt/tomcat
RUN mkdir -p /var/run/sshd
RUN /usr/bin/apt-get install -y openssh-server
RUN ssh-keygen -A
RUN rm -f /etc/ssh/sshd_config
ADD sshd_config /etc/ssh/
RUN echo root:jenkins | chpasswd
ADD start.sh /
RUN chmod +x /start.sh
EXPOSE 22
EXPOSE 8080
CMD ["/start.sh"]


SSHD_CONFIG

Port 22
Protocol 2

HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_dsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key

LoginGraceTime 120
PermitRootLogin yes
#StrictModes yes

#RSAAuthentication yes
PubkeyAuthentication yes
UsePAM yes

START_SH

#!/bin/bash

(/usr/sbin/sshd -D) & (/opt/tomcat/bin/catalina.sh run)


TOMCAT9-USERS.xml

<tomcat-users>
        <user username="intelliqit" password="intelliqit" roles="manager-script"/>
</tomcat-users>

Version 2 -> This one will only specify qa , prod and Jenkins server image building and conatiner launching :

docker-compose.yml file:

version: '3'
services:
        prodserver:
                build: .
                ports:
                        - "31946:22"
                        - 31945:8080



        jenkins:
                build: /workspace/workspace2/jenkins/
                ports:
                        - "31948:22"
                        - 31947:8080


        qaserver:
                build: .
                ports:
                        - "31944:22"
                        - 31943:8080

Docker file for qa server and prod server:

FROM ubuntu:latest
RUN /usr/bin/apt-get update -y
RUN /usr/bin/apt-get install -y apt-utils
RUN /usr/bin/apt-get install -y iputils-ping
RUN /usr/bin/apt-get install -y net-tools
RUN /usr/bin/apt-get install -y default-jdk
RUN /usr/bin/apt-get install -y tar
RUN /usr/bin/apt-get install -y wget
RUN cd /tmp
RUN /usr/bin/wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.39/bin/apache-tomcat-9.0.39.tar.gz
RUN mkdir /opt/tomcat
RUN tar xf apache-tomcat-9.0.39.tar.gz -C /opt/tomcat --strip-components=1
RUN useradd tomcat
RUN chgrp -R tomcat /opt/tomcat
RUN chmod -R g=x+r /opt/tomcat
RUN rm -f /opt/tomcat/tomcat-users.xml
ADD https://github.com/bmanoj0509/BMK/blob/master/tomcat9-users.xml /opt/tomcat
RUN mkdir -p /var/run/sshd
RUN /usr/bin/apt-get install -y openssh-server
RUN ssh-keygen -A
RUN rm -f /etc/ssh/sshd_config
ADD sshd_config /etc/ssh/
RUN echo root:jenkins | chpasswd
ADD start.sh /
RUN chmod +x /start.sh
EXPOSE 22
EXPOSE 8080
CMD ["/start.sh"]

sshd_config file for qa server and prod server:

Port 22
Protocol 2

HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_dsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key

LoginGraceTime 120
PermitRootLogin yes
#StrictModes yes

#RSAAuthentication yes
PubkeyAuthentication yes
UsePAM yes


start.sh script for both qa server and prod server :

#!/bin/bash

(/usr/sbin/sshd -D) & (/opt/tomcat/bin/catalina.sh run)

Dockerfile for Jenkins Server :
FROM ubuntu:latest
RUN /usr/bin/apt-get update -y
RUN /usr/bin/apt-get install -y apt-utils
RUN /usr/bin/apt-get install -y iputils-ping
RUN /usr/bin/apt-get install -y net-tools
RUN /usr/bin/apt-get install -y openjdk-8-jdk
RUN /usr/bin/apt-get install -y tar
RUN /usr/bin/apt-get install -y wget
RUN /usr/bin/apt-get install -y git maven
RUN wget https://get.jenkins.io/war-stable/2.249.1/jenkins.war
EXPOSE 22
EXPOSE 8080
CMD java -jar jenkins.war

Successfull code:




