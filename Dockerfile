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

Docker-compose file:

version: '3'
services:
        prodserver:
                build: .
                ports:
                        - "31946:22"
                        - 31945:8080



        jenkins:
                build: /workspace/workspace2/
                ports:
                        - "31948:22"
                        - 31947:8080


        qaserver:
                build: .
                ports:
                        - "31944:22"
                        - 31943:8080

Docker file for Prod Server and QA Server:

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
~                           
SSHD_Config

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

start.sh file :

#!/bin/bash
 
(/usr/sbin/sshd -D) & (/opt/tomcat/bin/catalina.sh run)

Docker file for Jenkins:

FROM ubuntu:latest
RUN /usr/bin/apt-get update -y
RUN /usr/bin/apt-get install -y apt-utils
RUN /usr/bin/apt-get install -y iputils-ping
RUN /usr/bin/apt-get install -y net-tools
RUN /usr/bin/apt-get install -y openjdk-8-jdk
RUN /usr/bin/apt-get install -y tar
RUN /usr/bin/apt-get install -y wget
RUN /usr/bin/apt-get install -y git maven
ADD jenkins.war /tmp
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

sshd_config for Jenkins:

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


start.sh file for Jenkins:

#!/bin/bash
 
(/usr/sbin/sshd -D) & (cd "/tmp" && java -jar jenkins.war)

IIEC Task2 <validating the user credentials and then assking for input commands and then printing the output )

Validating the user !!!

[root@test-server html]# cat /var/www/cgi-bin/pswdvalidation.py 
#!/usr/bin/python3
  
import cgi
form = cgi.FieldStorage()
inpass = form.getvalue("k")
if(inpass == "zbfzxBDBOX5"):
    print("content-type: text/html")
    print("location: http://34.101.132.215/iiectask2_new2.html")
    print()
else:
    print("content-type: text/html\r\n\r\n")
    print()
    print("Password authentication  is not successful")

Reading the inputs from validated user

[root@test-server html]# cat iiectask2_new2.html 
<form action = "http://34.101.132.215/cgi-bin/iiectask2.py" method = "post">
        <body style="background-color:yellow;text-align:center">
                <div style = "text-align: center; display:inline-block; width:1350px; margin:0px">
                        <div>
                                <font size = "+5">
                                        <b> Welcome to Red Hat Enterprise Linux 8 Operating System </b>
                                        </br>
                                        </br>
                                </font>
                                </br>
                                <font size ="+2">
                                        </br><u> Please choose any command from drop down box as per your query </u>

                                </br>
                                                <select name ='i'>
                                                        <option disabled selected value> -- select an option -- </option>
                                                        <option> ps -aux</option>
                                                        <option> date</option>
                                                        <option> cal</option>
                                                </select>
                                </font>
                                </br>
                                <font size ="+2">
                                        <u><br>Didn't you find your required command in dropdown list? Then enter your command below:(Beaware to use 'sudo' to make privilege esaclation)</br></u>

                                                <input name = 'j' type = 'text'>
                                                <input type = 'submit'/>
                                </font>
                        </div>
                </div>
        </body>
</form>

Giving the required for the query asked by validated user:

[root@test-server html]# cat /var/www/cgi-bin/iiectask2.py 
#!/usr/bin/python3
print("content-type: text/htmli\r\n\r\n")
print()
import subprocess as sp
import cgi
form = cgi.FieldStorage()
cmd1 = form.getvalue("i")
cmd2 = form.getvalue("j")
#cmd1 = "ps -aux"
#cmd2 = "systemctl ststus httpd"
print("Please wait while the system is executing your command !!!")
if(cmd1 is not None):
    if(cmd1 is not "-- select an option --"):
        output1=sp.getstatusoutput(cmd1)
        print('Output for your first command "{}" is'.format(cmd1))
        print(output1[1])
        print("\n\n\n")
if(cmd2 is not None):
    output2=sp.getstatusoutput(cmd2)
    if(output2[0] == 0):
        print('Output for your other command "{}" is'.format(cmd2))
        print(output2[1])
    else:
        print('This command "{}" execution is not successfull'.format(cmd2))
        print(output2[1])
        
    





