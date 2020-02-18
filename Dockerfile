FROM tomcat:latest

MAINTAINER AR Shankar

COPY .target/sparkjava-hello-world-1.0.war /usr/local/tomcat/webapps
