#!/usr/bin/env bash

hostname="hogwarts"
ip="10.1.30.2"

character_one="hagrid"
password_one="Yerawizardharry..."

character_two="harry"
password_two="I'mawhat?!"

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

#rm /tmp/password.txt

service smbd start 

