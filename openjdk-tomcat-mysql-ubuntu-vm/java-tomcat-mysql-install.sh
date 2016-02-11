

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
mysqlPassword=$4
sudo apt-get update
#no password prompt while installing mysql server
#export DEBIAN_FRONTEND=noninteractive

#another way of installing mysql server in a Non-Interactive mode
echo "mysql-server-5.6 mysql-server/root_password password $mysqlPassword" | sudo debconf-set-selections 
echo "mysql-server-5.6 mysql-server/root_password_again password $mysqlPassword" | sudo debconf-set-selections 

#install mysql-server 5.6
sudo apt-get install $3
