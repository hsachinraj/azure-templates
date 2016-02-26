# Install Java

sudo apt-get -y update
sudo apt-get install -y openjdk-7-jre

tomcatadminuser=$1
tomcatadminpwd=$2

#edit the tomcat users file
sudo apt-get install -y tomcat7 tomcat7-admin
sudo cp /etc/tomcat7/tomcat-users.xml /etc/tomcat7/tomcat-users.xml.bak
sed -i "s#</tomcat-users>##g" /etc/tomcat7/tomcat-users.xml; \
	echo '  <role rolename="manager-gui"/>' >>  /etc/tomcat7/tomcat-users.xml; \
	echo '  <role rolename="manager-script"/>' >>  /etc/tomcat7/tomcat-users.xml; \
	echo '  <role rolename="manager-jmx"/>' >>  /etc/tomcat7/tomcat-users.xml; \
	echo '  <role rolename="manager-status"/>' >>  /etc/tomcat7/tomcat-users.xml; \
	echo '  <role rolename="admin-gui"/>' >>  /etc/tomcat7/tomcat-users.xml; \
	echo '  <role rolename="admin-script"/>' >>  /etc/tomcat7/tomcat-users.xml; \
	echo '  <user username='\"$tomcatadminuser\" 'password='\"$tomcatadminpwd\" 'roles="manager-gui, manager-script, manager-jmx, manager-status, admin-gui, admin-script"/>' >>  /etc/tomcat7/tomcat-users.xml; \
	echo '</tomcat-users>' >> /etc/tomcat7/tomcat-users.xml
	
#restart Tomcat	
sudo service tomcat7 restart


#download the script file to be executed
sudo wget https://raw.githubusercontent.com/hsachinraj/azure-templates/master/openjdk-tomcat-mysql-ubuntu-vm/mydbscript.script
echo "file downloaded"

mysqlpassword=$3
sudo apt-get update
#no password prompt while installing mysql server
export DEBIAN_FRONTEND=noninteractive

#another way of installing mysql server in a Non-Interactive mode
echo "mysql-server mysql-server/root_password select $mysqlpassword" | sudo debconf-set-selections 
echo "mysql-server mysql-server/root_password_again select $mysqlpassword" | sudo debconf-set-selections 
sudo apt-get -y install mysql-server


#install mysql if not installed before
# status = $(dpkg-query -W -f='${Status}' mysql-server | awk '{print $3}')
# if [ "$status" = "installed" ];
# then
#echo "Skipping installation as package is alreayd installed"
#else
#install mysql-server 

#fi

mysql -u root --password="$mysqlpassword" -e 'create database alm'
mysql -u root --password="$mysqlpassword" < mydbscript.script

