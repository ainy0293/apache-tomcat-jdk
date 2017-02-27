FROM ubuntu:14.04
MAINTAINER Ainy Min <Email: ainy@ifool.me> <Website: http://ifool.me >
ENV REFRESHED_AT 2017-02-17

ENV JAVA_HOME /usr/local/jdk1.8
ENV JRE_HOME ${JAVA_HOME}/jre
ENV CLASS_PATH ${JAVA_HOME}/lib:${JRE_HOME}/lib

ENV CATALINA_HOME /usr/local/apache-tomcat-8.5.11

ENV CLASSPATH ${JAVA_HOME}/lib:${CATALINA_HOME}/lib
ENV PATH ${PATH}:${CATALINA_HOME}/bin:${JAVA_HOME}/bin

ADD tomcat.sh /root
WORKDIR /root
RUN ./tomcat.sh

VOLUME [ "/usr/local/apache-tomcat-8.5.11/webapps", "/usr/local/apache-tomcat-8.5.11/conf" ]

CMD ["/usr/local/apache-tomcat-8.5.11/bin/catalina.sh", "run" ]

EXPOSE 8080

