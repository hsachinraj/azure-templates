

# Install Java
sudo apt-get -y update
sudo apt-get install -y $1
sudo apt-get -y update --fix-missing
sudo apt-get install -y $1

# Install tomcat
sudo apt-get install -y  $2

if netstat -tulpen | grep 8080
then
	exit 0
fi

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
