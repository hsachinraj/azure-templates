

# Install Java
sudo apt-get -y update
sudo apt-get install -y $1
sudo apt-get -y update --fix-missing
sudo apt-get install -y $1

# Install tomcat
#sudo apt-get install -y  $2


#edit the tomcat users file
sudo apt-get install -y tomcat7 tomcat7-admin
sed -i "s#</tomcat-users>##g" /etc/tomcat7/tomcat-users.xml; \
	echo '  <role rolename="manager-gui"/>' >>  /etc/tomcat7/tomcat-users.xml; \
	echo '  <role rolename="manager-script"/>' >>  /etc/tomcat7/tomcat-users.xml; \
	echo '  <role rolename="manager-jmx"/>' >>  /etc/tomcat7/tomcat-users.xml; \
	echo '  <role rolename="manager-status"/>' >>  /etc/tomcat7/tomcat-users.xml; \
	echo '  <role rolename="admin-gui"/>' >>  /etc/tomcat7/tomcat-users.xml; \
	echo '  <role rolename="admin-script"/>' >>  /etc/tomcat7/tomcat-users.xml; \
	echo '  <user username="vmadmin" password="P2ssw0rd" roles="manager-gui, manager-script, manager-jmx, manager-status, admin-gui, admin-script"/>' >>  /etc/tomcat7/tomcat-users.xml; \
	echo '</tomcat-users>' >> /etc/tomcat7/tomcat-users.xml

#if netstat -tulpen | grep 8080
#then
#	exit 0
#fi
#Install MySQL
mysqlversion=$3
mysqlPassword='password'
sudo apt-get update
#no password prompt while installing mysql server
export DEBIAN_FRONTEND=noninteractive

#another way of installing mysql server in a Non-Interactive mode
echo "mysql-server mysql-server/root_password select $mysqlPassword" | sudo debconf-set-selections 
echo "mysql-server mysql-server/root_password_again select $mysqlPassword" | sudo debconf-set-selections 

#install mysql-server 5.6
sudo apt-get -y install mysql-server
