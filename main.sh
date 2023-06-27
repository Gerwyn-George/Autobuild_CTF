#!/usr/bin/env bash

hostname="hogwarts"
ip="10.0.20.4"

character_one="harry"
character_two="hagrid"

password_one="password123"
password_two="password123"



#source hogwarts_variables.sh
#source ACME_variables.sh
#source Chocolate_factory_variables.sh
#source xmen_variables.sh


function _set_hostname ()
{
    hostnamectl set-hostname $hostname

    if [[ $? -eq 0 ]]; then
        echo "Hostname change: SUCCESSFUL"
    else
        echo "Hostname change: FAILED"
    fi

}

function _backup_network_config ()
{
    if [ -f  "/etc/netplan/00-installer-config.yaml" ]; then

    mv /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.bk

    else
        echo "No configuration found"
    fi

    if [[ $? -eq 0 ]]; then
        echo "Original Network configuration backup: SUCCESSFUL"
    else
        echo "Original Network configuration backup: FAILED"
    fi

}

function _create_network_config ()
{
    touch /etc/netplan/network.yaml

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
                    via: 10.1.30.254
EOF

    if [[ $? -eq 0 ]]; then
        echo "Network configuration: SUCCESSFUL"
    else
        echo "Network configruation: FAILED"
    fi
}

function _configuring_host_file ()
{
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

    if [[ $? -eq 0 ]]; then
        echo "Host file configuration: SUCCESSFUL"
    else
        echo "Host file configuration: FAILED"
    fi
}

function _downloading_SAMBA_application ()
{
#Install samba and set it up.
    apt install samba samba-common-bin smbclient -y > /dev/null

    if [[ $? -eq 0 ]]; then
        echo "Installation of SAMBA application: SUCCESSFUL"
    else
        echo "Installation of SAMBA application: FAILED"
    fi
}

#set up users

function _setting_up_SAMBA ()
{

    cat > /home/$USER/password.txt << EOF
    $character_one:$password_one
    $character_two:$password_two
EOF

    cat /home/$USER/password.txt

    useradd -m $character_one
    useradd -m $character_two

    chpasswd < /home/$USER/password.txt

    rm /home/$USER/password.txt

    echo -ne "$password_one\n$password_one\n" | smbpasswd -a -s $character_one
    echo -ne "$password_two\n$password_two\n" | smbpasswd -a -s $character_two

    cat >> /etc/samba/smb.conf << EOF
    [Secret_Drive]
    comment = Secret shared drive do not add files here.
    browseable = yes
    writable = yes
    path = /tmp
    guest ok = yes
EOF

    service smbd start

    if [[ $? -eq 0 ]]; then
        echo "Configuration of SAMBA: SUCCESSFUL"
    else
        echo "Installation of SAMBA: FAILED"
    fi

}


function _download_SQL ()
{

    apt install mysql-server php libapache2-mod-php php-mysql -y > /dev/null

    if [[ $? -eq 0 ]]; then
        echo "Installation of database software: SUCCESSFUL"
    else
        echo "Installation of database software: FAILED"
    fi
}




function _set_up_database ()
{

    touch /etc/.my.cnf

    cat >> /etc/.my.cnf << EOF
    user=gerwyn
    password=password
EOF

    service mysql start

    mysql -e "CREATE DATABASE IF NOT EXISTS exploitable;"

    mysql -e "USE exploitable;"

    mysql -e "USE exploitable; CREATE TABLE IF NOT EXISTS accounts(cid INT NOT NULL AUTO_INCREMENT, username TEXT, password TEXT, is_admin VARCHAR(5), firstname TEXT, lastname TEXT, PRIMARY KEY(cid));"

    mysql -e "USE exploitable; INSERT INTO accounts (username, password, is_admin, firstname, lastname) VALUES ('gerwyn', 'password', 'TRUE', 'Gerwyn', 'George');"

    mysql -e "USE exploitable; SELECT * FROM accounts;"

}



function _install_web_server ()
{

    a2enmod php8.1

    apt install apache2 -y > /dev/null

    service apache2 start


    touch /var/www/html/welcome.html

    cat > /var/www/html/welcome.html << EOF

EOF

    touch /var/www/html/contact_us.html

    cat > /var/www/html/contact_us << EOF

EOF

    touch /var/www/html/login.html

    cat > /var/www/html/login.html << EOF

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>login</title>
    <link href="bootstrap/dist/css/bootstrap.css" rel="stylesheet">
  <style>
  .header {
    position: relative;
    left: 65px;
    padding-bottom: 40px;
    text-align: center;
  }

  .login_box {
    background-color: white;
    position: relative;
    left: 1125px;
  }

  .bottom{
        position:relative;
        text-align: center;
        top: 818px;
        left: 75px;
      }
  </style>

  </head>
  <body>

    <div class="container">
        <header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
          <a href="/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
            <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
            <span class="fs-4">Hogwarts</span>
          </a>

          <ul class="nav nav-pills">
            <li class="nav-item"><a href="home.html" class="nav-link" aria-current="page">Home</a></li>
            <li class="nav-item"><a href="About.html" class="nav-link">About</a></li>
            <li class="nav-item"><a href="opening hours.html" class="nav-link">opening hours</a></li>
            <li class="nav-item"><a href="Contact_Us.html" class="nav-link">Contact Us</a></li>
            <li class="nav-item"><a href="Login.html" class="nav-link active">Login</a></li>
          </ul>
        </header>
      </div>

    <h1 class="header">Login Page</h1>

    <div class="login_box">
        <form>
            <div class="mb-3" style="width:450px;">
                <label for="exampleInputEmail1" class="form-label">Username</label>
                <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
            </div>
            <div class="mb-3" style="width:450px;">
                <label for="exampleInputPassword1" class="form-label">Password</label>
                <input type="password" class="form-control" id="exampleInputPassword1">
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>

    <div class="bottom">
      <p>This site was created by Dobby the house elf. - 2023</p>
    </div>

  </body>
</html>

EOF




    touch /var/www/html/find_us.html

    cat > /var/www/html/find_us.html << EOF

EOF

    touch /var/www/html/secret.html

    cat > /var/www/html/secret.html << EOF

EOF

    service apache2 start

}

function _install_bootstrap ()
{
    if [[ ! -f /home/gerwyn/bootstrap.zip ]] then
    wget -O /home/gerwyn/bootstrap.zip https://github.com/twbs/bootstrap/archive/v5.1.3.zip
    echo "Downloaded bootstrap"
    else
    echo "Bootstrap already installed."
    fi

    apt install unzip

    unzip /home/gerwyn/bootstrap.zip -d  /home/gerwyn/bootstrap

    mkdir /var/www/html/bootstrap

    mkdir /var/www/html/bootstrap/dist

    mkdir /var/www/html/bootstrap/dist/css

    mkdir /var/www/html/bootstrap/dist/js

    mkdir /var/www/html/bootstrap/site

    mkdir /var/www/html/bootstrap/site/content/

    mkdir /var/www/html/bootstrap/site/content/docs

    mkdir /var/www/html/bootstrap/site/content/docs/5.1

    mkdir /var/www/html/bootstrap/site/content/docs/5.1/examples

    mkdir /var/www/html/bootstrap/js

    mkdir /var/www/html/bootstrap/scss

    cp -r /home/gerwyn/bootstrap/bootstrap-5.1.3/dist /var/www/html/bootstrap/

    cp -r /home/gerwyn/bootstrap/bootstrap-5.1.3/site /var/www/html/bootstrap/

    cp -r /home/gerwyn/bootstrap/bootstrap-5.1.3/js /var/www/html/bootstrap/

    cp -r /home/gerwyn/bootstrap/bootstrap-5.1.3/scss /var/www/html/bootstrap/
}





_set_hostname

_backup_network_config

_create_network_config

_configuring_host_file

_downloading_SAMBA_application

_setting_up_SAMBA

_download_SQL

_set_up_database

_install_web_server

_install_bootstrap

service apache2 restart
