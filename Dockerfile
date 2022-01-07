FROM centos:latest
RUN mkdir /opt/tomcat
WORKDIR /opt/tomcat
RUN yum update -y && yum install -y \
    java \
    git \
    wget
RUN MAJOR_TOMCAT_VER="10" && \
MED_TOMCAT_VER="10.0" && \
TOMCAT_VER=`curl --silent http://mirror.vorboss.net/apache/tomcat/tomcat-$MAJOR_TOMCAT_VER/ | grep v$MED_TOMCAT_VER | awk '{split($5,c,">v") ; split(c[2],d,"/") ; print d[1]}'` && \
wget https://dlcdn.apache.org/tomcat/tomcat-$MAJOR_TOMCAT_VER/v$TOMCAT_VER/bin/apache-tomcat-$TOMCAT_VER.tar.gz && \
tar -xvzf apache-tomcat-$TOMCAT_VER.tar.gz  && \
mv /opt/tomcat/apache-tomcat-$TOMCAT_VER/* /opt/tomcat
RUN chmod +x /opt/tomcat/bin/startup.sh
RUN chmod +x /opt/tomcat/bin/shutdown.sh
RUN ln -s /opt/tomcat/bin/startup.sh /usr/local/bin/tomcatup
RUN ln -s /opt/tomcat/bin/shutdown.sh /usr/local/bin/tomcatdown
EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh","run"]
#COPY ./*.war /usr/local/tomcat/webapps

