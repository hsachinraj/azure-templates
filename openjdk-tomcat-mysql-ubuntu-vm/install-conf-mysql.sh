#Install MySQL
mysqlPassword=$1
sudo apt-get update
#no password prompt while installing mysql server
export DEBIAN_FRONTEND=noninteractive

#another way of installing mysql server in a Non-Interactive mode
echo "mysql-server mysql-server/root_password select $mysqlPassword" | sudo debconf-set-selections 
echo "mysql-server mysql-server/root_password_again select $mysqlPassword" | sudo debconf-set-selections 
#download the script file to be executed
sudo wget https://raw.githubusercontent.com/hsachinraj/azure-templates/master/openjdk-tomcat-mysql-ubuntu-vm/mydbscript.script
echo "file downloaded"

#install mysql if not installed before
 status = $(dpkg-query -W -f='${Status}' mysql-server | awk '{print $3}')
 if [ "$status" = "installed" ];
 then
#install mysql-server 
echo "Skipping installation as package is alreayd installed"
sudo apt-get -y install mysql-server
fi

mysql -u root --password=$mysqlPassword -e 'create database alm'
mysql -u root --password=$mysqlpassword -D alm < mydbscript.script
