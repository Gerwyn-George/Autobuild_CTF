#!/usr/bin/env bash

#hostname="hogwarts"
#ip="10.0.20.4"

#character_one="harry"
#character_two="hagrid"
#character_three=


#password_one="password123"
#password_two="password123"



source Hogwarts_variables.sh
#source ACME_variables.sh
#source Chocolate_factory_variables.sh
#source xmen_variables.sh


function _set_hostname ()
{
    hostnamectl set-hostname $HOSTNAME

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
                    - ${IP}/24
                nameservers:
                    addresses: [8.8.8.8, ${GATEWAY_IP}]
                routes:
                    - to: default
                    via: ${GATEWAY_IP}
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
    127.0.1.1 ${HOSTNAME}

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

    cat > /$HOME/password.txt << EOF
    $character_one:$password_one
    $character_two:$password_two
    $character_three:$password_three
    $character_four:$password_four
    $character_five:$password_five
    $character_six:$password_six
    $character_seven:$password_seven
EOF

    cat /$HOME/password.txt

    useradd -m $character_one
    useradd -m $character_two
    useradd -m $character_three
    useradd -m $character_four
    useradd -m $character_five
    useradd -m $character_six
    useradd -m $character_seven

#    chpasswd < /$HOME/password.txt

    echo $character_one:$password_one | sudo chpasswd
    echo $character_two:$password_two | sudo chpasswd
    echo $character_three:$password_three |sudo chpasswd
    echo $character_four:$password_four | sudo chpasswd
    echo $character_five:$password_five | sudo chpasswd
    echo $character_six:$password_six | sudo chpasswd
    echo $character_seven:$password_seven | sudo chpasswd



    rm /$HOME/password.txt

    echo -ne "$password_one\n$password_one\n" | smbpasswd -a -s $character_one
    echo -ne "$password_two\n$password_two\n" | smbpasswd -a -s $character_two
    echo -ne "$password_three\n$password_three\n" | smbpasswd -a -s $character_three
    echo -ne "$password_four\n$password_four\n" | smbpasswd -a -s $character_four
    echo -ne "$password_five\n$password_five\n" | smbpasswd -a -s $character_five
    echo -ne "$password_six\n$password_six\n" | smbpasswd -a -s $character_six
    echo -ne "$password_seven\n$password_seven\n" | smbpasswd -a -s $character_seven

    smbpasswd -e  $character_one
    smbpasswd -e  $character_two
    smbpasswd -e  $character_three
    smbpasswd -e  $character_four
    smbpasswd -e  $character_five
    smbpasswd -e  $character_six
    smbpasswd -e  $character_seven

    cat >> /etc/samba/smb.conf << EOF
    [Secret_Drive]
    comment = Secret shared drive do not add files here.
    browseable = yes
    writable = yes
    path = /srv/Secret_Drive
    guest ok = yes
EOF

    #Create shared drive
    if [[ ! -d /srv/Secret_Drive ]] ; then
        mkdir /srv/Secret_Drive
        echo "Attempting to create shared drive."

        if [[ $? -eq 0 ]] ; then
                echo "Shared Drive created at /srv/Secret_Drive"
        else
                echo "Unable to create shared Drive."
        fi
    else
        echo "Shared drive already exsists."
    fi


    #Modify the workgroup to show the Third secret Flag.
    sed -i "s/WORKGROUP/FLAG{"${SECRET_FLAG_THREE}"}/" /etc/samba/smb.conf

    #This file is the key within the shared drive.

    if  [[ ! -f /srv/Secret_Drive/note ]] ; then
        echo "Attempting to create the secret share file."
        touch /srv/Secret_Drive/note
        if  [[ $? -eq 0 ]] ; then
                echo "Created secret share file."
                echo "FLAG{"${SECRET_FLAG_FOUR}"}" >> /srv/Secret_Drive/note
        else
                echo "Unable to created secret share file."
        fi
    else
        echo "Secret share file already exsists."
    fi

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
    user=admin_account
    password=password

EOF

    mysql -e "DROP DATABASE IF EXISTS exploitable;"

    mysql -e "CREATE DATABASE IF NOT EXISTS exploitable;"

    mysql -e "CREATE USER IF NOT EXISTS 'admin_account'@'localhost' IDENTIFIED BY 'password';"

    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'admin_account'@'localhost' WITH GRANT OPTION;"

    mysql -e "FLUSH PRIVILEGES;"

    mysql -e "USE exploitable;"

    mysql -e "USE exploitable; CREATE TABLE IF NOT EXISTS accounts(cid INT NOT NULL AUTO_INCREMENT, username TEXT, password TEXT, is_admin VARCHAR(5), firstname TEXT, lastname TEXT, signature TEXT, PRIMARY KEY(cid));"

    #mysql -e "USE exploitable; INSERT INTO accounts (username, password, is_admin, firstname, lastname, signature) VALUES ('gerwyn', 'password', 'TRUE', 'Gerwyn', 'George', 'Here is my signature');"

    mysql -e "USE exploitable; INSERT INTO accounts (username, password, is_admin, firstname, lastname, signature) VALUES ('$db_character_one_user', '$db_character_one_password', '$db_character_one_is_admin', '$db_character_one_firstname', '$db_character_one_lastname', 'FLAG{$SECRET_FLAG_FIVE}');"

    mysql -e "USE exploitable; INSERT INTO accounts (username, password, is_admin, firstname, lastname, signature) VALUES ('$db_character_two_user', '$db_character_two_password', '$db_character_two_is_admin', '$db_character_two_firstname', '$db_character_two_lastname', '$db_character_two_signature');"

    mysql -e "USE exploitable; INSERT INTO accounts (username, password, is_admin, firstname, lastname, signature) VALUES ('$db_character_three_user', '$db_character_three_password', '$db_character_three_is_admin', '$db_character_three_firstname', '$db_character_three_lastname', '$db_character_three_signature');"

    mysql -e "USE exploitable; INSERT INTO accounts (username, password, is_admin, firstname, lastname, signature) VALUES ('$db_character_four_user', '$db_character_four_password', '$db_character_four_is_admin', '$db_character_four_firstname', '$db_character_four_lastname', '$db_character_four_signature');"

    mysql -e "USE exploitable; INSERT INTO accounts (username, password, is_admin, firstname, lastname, signature) VALUES ('$db_character_five_user', '$db_character_five_password', '$db_character_five_is_admin', '$db_character_five_firstname', '$db_character_five_lastname', '$db_character_five_signature');"

    mysql -e "USE exploitable; INSERT INTO accounts (username, password, is_admin, firstname, lastname, signature) VALUES ('$db_character_six_user', '$db_character_six_password', '$db_character_six_is_admin', '$db_character_six_firstname', '$db_character_six_lastname', '$db_character_six_signature');"

    mysql -e "USE exploitable; INSERT INTO accounts (username, password, is_admin, firstname, lastname, signature) VALUES ('${db_character_seven_user}', '${db_character_seven_password}', '${db_character_seven_is_admin}', '${db_character_seven_firstname}', '${db_character_seven_lastname}', '${db_character_seven_signature}');"

    mysql -e "USE exploitable; SELECT * FROM accounts;"

#make port available to all.

    sed -i "s/^bind-address.*/bind-address  = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

    service mysql start

    service mysql restart
}



function _install_web_server ()
{

    a2enmod php8.1

    apt install apache2 -y > /dev/null

    #remove old data
    rm /var/www/html/*.html
    rm /var/www/html/*.php

    #Welcome page

    cp /home/admin_account/home.html /var/www/html/home.html

    sed -i "s/SITE_NAME/$SITE_NAME/" /var/www/html/home.html
    sed -i "s/WELCOME_MESSAGE/$WELCOME/" /var/www/html/home.html
    sed -i "s/WEBSITE_CREATED_BY/$WEBSITE_CREATED_BY/" /var/www/html/home.html

    #About page

    cp /home/admin_account/about.html /var/www/html/about.html

    sed -i "s/SITE_NAME/$SITE_NAME/" /var/www/html/about.html
    sed -i "s/WEBSITE_CREATED_BY/$WEBSITE_CREATED_BY/" /var/www/html/about.html
    sed -i "s/ABOUT_ONE/$ABOUT_ONE/" /var/www/html/about.html
    sed -i "s/ABOUT_TWO/$ABOUT_TWO/" /var/www/html/about.html
    sed -i "s/ABOUT_THREE/$ABOUT_THREE/" /var/www/html/about.html

    #Opening hours page

    cp "/home/admin_account/time.html" "/var/www/html/time.html"

    sed -i "s/SITE_NAME/$SITE_NAME/" "/var/www/html/time.html"
    sed -i "s/WEBSITE_CREATED_BY/$WEBSITE_CREATED_BY/" "/var/www/html/time.html"
    sed -i "s/SECRET_FLAG_ONE/$SECRET_FLAG_ONE/" "/var/www/html/time.html"

    #Login page

    cp "/home/admin_account/login.php" /var/www/html/login.php

    sed -i "s/SITE_NAME/$SITE_NAME/" /var/www/html/login.php
    sed -i "s/WEBSITE_CREATED_BY/$WEBSITE_CREATED_BY/" /var/www/html/login.php


    #secret page

    cp /home/admin_account/secret.html /var/www/html/secret.html

    sed -i "s/SECRET_FLAG_TWO/$SECRET_FLAG_TWO/" /var/www/html/secret.html
    sed -i "s/WEBSITE_CREATED_BY/$WEBSITE_CREATED_BY/" /var/www/html/secret.html
    #Contact Us page set up.

    cp /home/admin_account/contact_us.html /var/www/html/contact_us.html

    sed -i "s/SITE_NAME/$SITE_NAME/" /var/www/html/contact_us.html

    sed -i "s/ROW_ONE_FIRSTNAME/$db_character_one_firstname/" /var/www/html/contact_us.html
    sed -i "s/ROW_ONE_SURNAME/$db_character_one_lastname/" /var/www/html/contact_us.html
    sed -i "s/ROW_ONE_EMAIL/$CONTACT_EMAIL_ONE/" /var/www/html/contact_us.html

    sed -i "s/ROW_TWO_FIRSTNAME/$db_character_two_firstname/" /var/www/html/contact_us.html
    sed -i "s/ROW_TWO_SURNAME/$db_character_two_lastname/" /var/www/html/contact_us.html
    sed -i "s/ROW_TWO_EMAIL/$CONTACT_EMAIL_TWO/" /var/www/html/contact_us.html

    sed -i "s/ROW_THREE_FIRSTNAME/$db_character_three_firstname/" /var/www/html/contact_us.html
    sed -i "s/ROW_THREE_SURNAME/$db_character_three_lastname/" /var/www/html/contact_us.html
    sed -i "s/ROW_THREE_EMAIL/$CONTACT_EMAIL_THREE/" /var/www/html/contact_us.html

    sed -i "s/ROW_FOUR_FIRSTNAME/$db_character_four_firstname/" /var/www/html/contact_us.html
    sed -i "s/ROW_FOUR_SURNAME/$db_character_four_lastname/" /var/www/html/contact_us.html
    sed -i "s/ROW_FOUR_EMAIL/$CONTACT_EMAIL_FOUR/" /var/www/html/contact_us.html

    sed -i "s/ROW_FIVE_FIRSTNAME/$db_character_five_firstname/" /var/www/html/contact_us.html
    sed -i "s/ROW_FIVE_SURNAME/$db_character_five_lastname/" /var/www/html/contact_us.html
    sed -i "s/ROW_FIVE_EMAIL/$CONTACT_EMAIL_FIVE/" /var/www/html/contact_us.html

    sed -i "s/ROW_SIX_FIRSTNAME/$db_character_six_firstname/" /var/www/html/contact_us.html
    sed -i "s/ROW_SIX_SURNAME/$db_character_six_lastname/" /var/www/html/contact_us.html
    sed -i "s/ROW_SIX_EMAIL/$CONTACT_EMAIL_SIX/" /var/www/html/contact_us.html

    sed -i "s/ROW_SEVEN_FIRSTNAME/$db_character_seven_firstname/" /var/www/html/contact_us.html
    sed -i "s/ROW_SEVEN_SURNAME/$db_character_seven_lastname/" /var/www/html/contact_us.html
    sed -i "s/ROW_SEVEN_EMAIL/$CONTACT_EMAIL_SEVEN/" /var/www/html/contact_us.html

    sed -i "s/WEBSITE_CREATED_BY/$WEBSITE_CREATED_BY/" /var/www/html/contact_us.html

    service apache2 start

}

function _install_bootstrap ()
{
    if [[ ! -f /home/admin_account/bootstrap.zip ]] ; then
    wget -O /home/admin_account/bootstrap.zip https://github.com/twbs/bootstrap/archive/v5.1.3.zip
    echo "Downloaded bootstrap"
    else
    echo "Bootstrap already installed."
    fi

    apt install unzip

    unzip -o /home/admin_account/bootstrap.zip -d  /home/admin_account/bootstrap

    if [[ ! -d /var/www/html/bootstrap ]] ; then
        echo "Creating directory."
        mkdir /var/www/html/bootstrap
    else
        echo "Directory already exsists."
    fi


    if [[ ! -d /var/www/html/bootstrap/dist ]] ; then
        echo "Creating directory."
        mkdir /var/www/html/bootstrap/dist
    else
        echo "Directory already exsists."
    fi


    if [[ ! -d /var/www/html/bootstrap/dist/css ]] ; then
        echo "Creating directory."
        mkdir /var/www/html/bootstrap/dist/css
    else
        echo "Directory already exsists"
    fi


    if [[ ! -d /var/www/html/bootstrap/dist/js ]] ; then
        echo "Creating directory."
        mkdir /var/www/html/bootstrap/dist/js
    else
        echo "Directory already exsists"
    fi


    if  [[ ! -d /var/www/html/bootstrap/site ]] ; then
        echo "Creating directory."
        mkdir /var/www/html/bootstrap/site
    else
        echo "Directory already exsists."
    fi


    if [[ ! -d /var/www/html/bootstrap/site/content/ ]] ; then
        echo "Creating directory."
        mkdir /var/www/html/bootstrap/site/content/
    else
        echo "Directory already exsists."
    fi


    if [[ ! -d /var/www/html/bootstap/site/content/docs ]] ; then
        echo "Creating directory."
        mkdir /var/www/html/bootstrap/site/content/docs
    else
        echo "Directory already exsists."
    fi


    if [[ ! -d /var/www/html/bootstrap/site/content/docs/5.1 ]] ; then
        echo "Creating directory."
        mkdir /var/www/html/bootstrap/site/content/docs/5.1
    else
        echo "Directory already exsists."
    fi


    if [[ ! -d /var/www/html/bootstrap/site/content/docs/5.1/examples ]] ; then
        echo "Creating directory."
        mkdir /var/www/html/bootstrap/site/content/docs/5.1/examples
    else
        echo "Directory already exsists."
    fi


    if [[ ! -d /var/www/html/bootstrap/js ]] ; then
        echo "Creating directory."
        mkdir /var/www/html/bootstrap/js
    else
        echo "Directory already exsists."
    fi


    if [[ ! -d /var/www/html/bootstrap/scss ]] ; then
        echo "Creating directory."
        mkdir /var/www/html/bootstrap/scss
    else
        echo "Directory already exsists."
    fi

    cp -rf /home/admin_account/bootstrap/bootstrap-5.1.3/dist /var/www/html/bootstrap/

    cp -rf /home/admin_account/bootstrap/bootstrap-5.1.3/site /var/www/html/bootstrap/

    cp -rf /home/admin_account/bootstrap/bootstrap-5.1.3/js /var/www/html/bootstrap/

    cp -rf /home/admin_account/bootstrap/bootstrap-5.1.3/scss /var/www/html/bootstrap/
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
