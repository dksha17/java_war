FROM tomcat:latest

MAINTAINER Deeksha Nayyar

COPY target/sparkjava-hello-world-1.0.war /usr/local/tomcat/webapps
