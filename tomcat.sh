#!/bin/bash
if [ $(id -u) -ne "0" ]; then
	echo "Error: You must be root to run this script, please use root to install"
	echo "or use sudo command!!"
	exit 1
fi

# modify apt source to 163 mirror site
cat > /etc/apt/sources.list << EOF
deb http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse
EOF

apt-get -y update
apt-get -y install wget tar

JAVA_HOME=/usr/local/jdk1.8
JRE_HOME=${JAVA_HOME}/jre
CLASS_PATH=${JAVA_HOME}/lib:${JRE_HOME}/lib
#PATH=${JAVA_HOME}/bin:$PATH

CATALINA_HOME=/usr/local/apache-tomcat-8.5.11
CLASSPATH=.:${JAVA_HOME}/lib:${CATALINA_HOME}/lib
PATH=${PATH}:$CATALINA_HOME/bin:${JAVA_HOME}/bin

#check file

if [ ! -f jdk-8u121-linux-x64.tar.gz ]; then
	echo "jdk-8u121-linux-x64.tar.gz does not exist!"
	echo "Begin download now"
	wget -c http://ocwljlzzv.bkt.clouddn.com/soft/jdk-8u121-linux-x64.tar.gz
fi
if [ ! -f apache-tomcat-8.5.11.tar.gz ]; then
	echo "apache-tomcat-8.5.11.tar.gz  does not exist!"
	echo "Begin download now"
	wget -c http://mirrors.cnnic.net/apache/tomcat/tomcat-8/v8.5.11/bin/apache-tomcat-8.5.11.tar.gz
fi

tar -zxvf jdk-8u121-linux-x64.tar.gz 
tar -zxvf apache-tomcat-8.5.11.tar.gz
mv jdk1.8.0_121 /usr/local/jdk1.8
mv apache-tomcat-8.5.11 /usr/local/

apt-get -y clean
apt-get -y autoclean

rm -f jdk-8u121-linux-x64.tar.gz apache-tomcat-8.5.11.tar.gz

echo '# jdk' >> /etc/profile
echo 'export JAVA_HOME=/usr/local/jdk1.8' >> /etc/profile
echo 'export JRE_HOME=${JAVA_HOME}/jre' >> /etc/profile
echo 'export CLASS_PATH=${JAVA_HOME}/lib:${JRE_HOME}/lib' >> /etc/profile
echo '#apache-tomcat' >> /etc/profile
echo 'export CATALINA_HOME=/usr/local/apache-tomcat-8.5.11' >> /etc/profile
echo 'export CLASSPATH=.:${JAVA_HOME}/lib:${CATALINA_HOME}/lib' >> /etc/profile
echo 'export PATH=${PATH}:$CATALINA_HOME/bin:${JAVA_HOME}/bin' >> /etc/profile

java -version
if [ "$?" -eq "0" ]; then
	echo "JDK install Success! "
else
	echo "JDK install Failed! "
	exit 1
fi

