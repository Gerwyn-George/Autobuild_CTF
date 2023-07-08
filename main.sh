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

    chpasswd < /$HOME/password.txt

    rm /$HOME/password.txt

    echo -ne "$password_one\n$password_one\n" | smbpasswd -a -e -s $character_one
    echo -ne "$password_two\n$password_two\n" | smbpasswd -a -e -s $character_two
    echo -ne "$password_three\n$password_three\n" | smbpasswd -a -e -s $character_three
    echo -ne "$password_four\n$password_four\n" | smbpasswd -a -e -s $character_four
    echo -ne "$password_five\n$password_five\n" | smbpasswd -a -e -s $character_five
    echo -ne "$password_six\n$password_six\n" | smbpasswd -a -e -s $character_six
    echo -ne "$password_seven\n$password_seven\n" | smbpasswd -a -e -s $character_seven

    cat >> /etc/samba/smb.conf << EOF
    [Secret_Drive]
    comment = Secret shared drive do not add files here.
    browseable = yes
    writable = yes
    path = /srv/Secret_Drive
    guest ok = yes
EOF


    #Create shared drive
    mkdir /srv/Secret_Drive

    #Modify the workgroup to show the Third secret Flag.
    sed -i "s/WORKGROUP/FLAG{$SECRET_KEY_THREE}/" /etc/samba/smb.conf

    #This file is the key within the shared drive.
    touch /srv/Secret_Drive/note.txt

    echo "FLAG{$SECRET_KEY_FOUR}" >> /srv/Secret_Drive/note.txt

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

    mysql -e "DROP DATABASE IF EXISTS exploitable;"

    mysql -e "CREATE DATABASE IF NOT EXISTS exploitable;"

    mysql -e "CREATE USER 'gerwyn'@'localhost' IDENTIFIED BY '';"

    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'gerwyn'@'localhost' WITH GRANT OPTION;"

    mysql -e "FLUSH PRIVILEGES;"

    mysql -e "USE exploitable;"

    mysql -e "USE exploitable; CREATE TABLE IF NOT EXISTS accounts(cid INT NOT NULL AUTO_INCREMENT, username TEXT, password TEXT, is_admin VARCHAR(5), firstname TEXT, lastname TEXT, signature TEXT, PRIMARY KEY(cid));"

    #mysql -e "USE exploitable; INSERT INTO accounts (username, password, is_admin, firstname, lastname, signature) VALUES ('gerwyn', 'password', 'TRUE', 'Gerwyn', 'George', 'Here is my signature');"

    mysql -e "USE exploitable; INSERT INTO accounts (username, password, is_admin, firstname, lastname, signature) VALUES ('$db_character_one_user', '$db_character_one_password', '$db_character_one_is_admin', '$db_character_one_firstname', '$db_character_one_lastname', '$db_character_one_signature');"

    mysql -e "USE exploitable; INSERT INTO accounts (username, password, is_admin, firstname, lastname, signature) VALUES ('$db_character_two_user', '$db_character_two_password', '$db_character_two_is_admin', '$db_character_two_firstname', '$db_character_two_lastname', '$db_character_two_signature');"

    mysql -e "USE exploitable; INSERT INTO accounts (username, password, is_admin, firstname, lastname, signature) VALUES ('$db_character_three_user', '$db_character_three_password', '$db_character_three_is_admin', '$db_character_three_firstname', '$db_character_three_lastname', '$db_character_three_signature');"

    mysql -e "USE exploitable; INSERT INTO accounts (username, password, is_admin, firstname, lastname, signature) VALUES ('$db_character_four_user', '$db_character_four_password', '$db_character_four_is_admin', '$db_character_four_firstname', '$db_character_four_lastname', '$db_character_four_signature');"

    mysql -e "USE exploitable; INSERT INTO accounts (username, password, is_admin, firstname, lastname, signature) VALUES ('$db_character_five_user', '$db_character_five_password', '$db_character_five_is_admin', '$db_character_five_firstname', '$db_character_five_lastname', '$db_character_five_signature');"

    mysql -e "USE exploitable; INSERT INTO accounts (username, password, is_admin, firstname, lastname, signature) VALUES ('$db_character_six_user', '$db_character_six_password', '$db_character_six_is_admin', '$db_character_six_firstname', '$db_character_six_lastname', '$db_character_six_signature');"

    mysql -e "USE exploitable; INSERT INTO accounts (username, password, is_admin, firstname, lastname, signature) VALUES ('${db_character_seven_user}', '${db_character_seven_password}', '${db_character_seven_is_admin}', '${db_character_seven_firstname}', '${db_character_seven_lastname}', '${db_character_seven_signature}');"

    mysql -e "USE exploitable; SELECT * FROM accounts;"

}



function _install_web_server ()
{

    a2enmod php8.1

    apt install apache2 -y > /dev/null

    #Welcome page

    cp /home/gerwyn/home.html /var/www/html/home.html

    sed -i "s/SITE_NAME/$SITE_NAME/" /var/www/html/home.html
    sed -i "s/WELCOME_MESSAGE/$WELCOME/" /var/www/html/home.html
    sed -i "s/WEBSITE_CREATED_BY/$WEBSITE_CREATED_BY/" /var/www/html/home.html

    #About page

    cp /home/gerwyn/About.html /var/www/html/About.html

    sed -i "s/SITE_NAME/$SITE_NAME/" /var/www/html/About.html
    sed -i "s/WEBSITE_CREATED_BY/$WEBSITE_CREATED_BY/" /var/www/html/About.html
    sed -i "s/ABOUT_ONE/$ABOUT_ONE/" /var/www/html/About.html
    sed -i "s/ABOUT_TWO/$ABOUT_TWO/" /var/www/html/About.html
    sed -i "s/ABOUT_THREE/$ABOUT_THREE/" /var/www/html/About.html

    #Opening hours page

    cp "/home/gerwyn/opening hours.html" "/var/www/html/opening hours.html"

    sed -i "s/SITE_NAME/$SITE_NAME/" "/var/www/html/opening hours.html"
    sed -i "s/WEBSITE_CREATED_BY/$WEBSITE_CREATED_BY/" "/var/www/html/opening hours.html"


    #Login page

    #cp "/home/gerwyn/login.html" "/var/www/html/login.html

    #sed -i "/SITE_NAME/$SITE_NAME/" /var/www/html/login.html
    #sed -i "/WEBSITE_CREATED_BY/$WEBSITE_CREATED_BY/" /var/www/html/login.html


    #Contact Us page set up.

    cp /home/gerwyn/Contact_Us.html /var/www/html/Contact_Us.html

    sed -i "s/SITE_NAME/$SITE_NAME/" /var/www/html/Contact_Us.html

    sed -i "s/ROW_ONE_FIRSTNAME/$db_character_one_firstname/" /var/www/html/Contact_Us.html
    sed -i "s/ROW_ONE_SURNAME/$db_character_one_lastname/" /var/www/html/Contact_Us.html
    sed -i "s/ROW_ONE_EMAIL/$CONTACT_EMAIL_ONE/" /var/www/html/Contact_Us.html

    sed -i "s/ROW_TWO_FIRSTNAME/$db_character_two_firstname/" /var/www/html/Contact_Us.html
    sed -i "s/ROW_TWO_SURNAME/$db_character_two_lastname/" /var/www/html/Contact_Us.html
    sed -i "s/ROW_TWO_EMAIL/$CONTACT_EMAIL_TWO/" /var/www/html/Contact_Us.html

    sed -i "s/ROW_THREE_FIRSTNAME/$db_character_three_firstname/" /var/www/html/Contact_Us.html
    sed -i "s/ROW_THREE_SURNAME/$db_character_three_lastname/" /var/www/html/Contact_Us.html
    sed -i "s/ROW_THREE_EMAIL/$CONTACT_EMAIL_THREE/" /var/www/html/Contact_Us.html

    sed -i "s/ROW_FOUR_FIRSTNAME/$db_character_four_firstname/" /var/www/html/Contact_Us.html
    sed -i "s/ROW_FOUR_SURNAME/$db_character_four_lastname/" /var/www/html/Contact_Us.html
    sed -i "s/ROW_FOUR_EMAIL/$CONTACT_EMAIL_FOUR/" /var/www/html/Contact_Us.html

    sed -i "s/ROW_FIVE_FIRSTNAME/$db_character_five_firstname/" /var/www/html/Contact_Us.html
    sed -i "s/ROW_FIVE_SURNAME/$db_character_five_lastname/" /var/www/html/Contact_Us.html
    sed -i "s/ROW_FIVE_EMAIL/$CONTACT_EMAIL_FIVE/" /var/www/html/Contact_Us.html

    sed -i "s/ROW_SIX_FIRSTNAME/$db_character_six_firstname/" /var/www/html/Contact_Us.html
    sed -i "s/ROW_SIX_SURNAME/$db_character_six_lastname/" /var/www/html/Contact_Us.html
    sed -i "s/ROW_SIX_EMAIL/$CONTACT_EMAIL_SIX/" /var/www/html/Contact_Us.html

    sed -i "s/ROW_SEVEN_FIRSTNAME/$db_character_seven_firstname/" /var/www/html/Contact_Us.html
    sed -i "s/ROW_SEVEN_SURNAME/$db_character_seven_lastname/" /var/www/html/Contact_Us.html
    sed -i "s/ROW_SEVEN_EMAIL/$CONTACT_EMAIL_SEVEN/" /var/www/html/Contact_Us.html

    sed -i "s/WEBSITE_CREATED_BY/$WEBSITE_CREATED_BY/" /var/www/html/Contact_Us.html

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
