#!/usr/bin/env bash

hostname="hogwarts"
ip="10.1.30.2"

character_one="harry"
character_two="hagrid"

password_one="password123"
password_two="password123"


#Set up the intial configuration

echo "Changing the hostname of the machine to $hostname."

hostnamectl set-hostname $hostname

echo "Backing up the default netplan file."

mv /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.bk

echo "Creating a network config file."

touch /etc/netplan/network.yaml

echo "changing the IP address of the machine to $ip."

cat > /etc/netplan/network.yaml << EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      addresses:
        - ${ip}/24
      nameservers:
        addresses: [8.8.8.8]
      routes:
        - to: default
          via: 10.1.30.1          
EOF

echo "Changing the host file of the machine."

cat > /etc/hosts << EOF
127.0.0.1 localhost
127.0.1.1 ${hostname}

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOF

#Install samba and set it up. 

echo "Downloading and Installing the Samba Server"

apt install samba samba-common-bin -y

apt install smbclient -y 


#set up users

touch /home/gerwyn/password.txt

cat > /home/gerwyn/password.txt << EOF
$character_one:$password_one
$character_two:$password_two
EOF

cat /home/gerwyn/password.txt

useradd -m $character_one
useradd -m $character_two

chpasswd < /home/gerwyn/password.txt

rm /home/gerwyn/password.txt

#Add smb users

echo -ne "$password_one\n$password_one\n" | smbpasswd -a -s $character_one
echo -ne "$password_two\n$password_two\n" | smbpasswd -a -s $character_two

#set up the configuration for a shared drive. 

cat >> /etc/samba/smb.conf << EOF
[Secret_Drive]
  comment = Secret shared drive do not add files here. 
  browseable = yes
  writable = yes
  path = /tmp
  guest ok = yes
EOF

echo "Attempting to start up smbd service"

service smbd start 

#set up the configuration for the database element. 

apt install mysql-server -y 

apt install php libapache2-mod-php php-mysql -y

a2enmod php8.1

touch /etc/.my.cnf

cat >> /etc/.my.cnf << EOF
user=gerwyn
password=password
EOF

service mysql start

echo "Creating database exploitable."

mysql -e "CREATE DATABASE IF NOT EXISTS exploitable;"

echo "Using database exploitable."

mysql -e "USE exploitable;"

echo "Creating Table accounts"

mysql -e "USE exploitable; CREATE TABLE IF NOT EXISTS accounts(cid INT NOT NULL AUTO_INCREMENT, username TEXT, password TEXT, is_admin VARCHAR(5), firstname TEXT, lastname TEXT, PRIMARY KEY(cid));"

echo "Inserting data into the accounts table within the exploitable database."

mysql -e "USE exploitable; INSERT INTO accounts (username, password, is_admin, firstname, lastname) VALUES ('gerwyn', 'password', 'TRUE', 'Gerwyn', 'George');"

echo "show data within table accounts"

mysql -e "USE exploitable; SELECT * FROM accounts;"



#set up the web server element.

echo "Attempting to start up Apache install"

apt install apache2 -y 

echo "Attempting to start apache2 service"

service apache2 start

echo "creating webpages."

touch /var/www/html/welcome.html

touch /var/www/html/contact_us.html

touch /var/www/html/login.html

touch /var/www/html/find_us.html

touch /var/www/html/secret.html





