#!/usr/bin/env bash


#CTF Machine details

HOSTNAME="Hogwarts"
IP="10.0.20.4"
GATEWAY_IP=""

#character information for the user creation.
character_one="Harry"
character_two="Hermione"
character_three="Ron"
character_four="Hedwig"
character_five="Albus"
character_six="Severus"
character_seven="Rubeus"

password_one="password123"
password_two="password123"
password_three="password123"
password_four="password123"
password_five="password123"
password_six="password123"
password_seven="password123"

#Here is the Database information variables

#Character_one

db_character_one_user="Harry"
db_character_one_password="password123"
db_character_one_is_admin="FALSE"
db_character_one_firstname="Harry"
db_character_one_lastname="Potter"
db_character_one_signature="I solemnly swear that I am up to no good."

#Character_two#

db_character_two_user="Hermione"
db_character_two_password="password123"
db_character_two_is_admin="FALSE"
db_character_two_firstname="Hermione"
db_character_two_lastname="Grainger"
db_character_two_signature="It\'s leviOsa, not levioSA!"


#Character_three
db_character_three_user="Ron"
db_character_three_password="password123"
db_character_three_is_admin="FALSE"
db_character_three_firstname="Ronald"
db_character_three_lastname="Weasley"
db_character_three_signature="Why Spiders? Why couldn\'t it be, Follow the buterflies?"

#Character_four
db_character_four_user="Hedwig"
db_character_four_password="password123"
db_character_four_is_admin="FALSE"
db_character_four_firstname="Hedwig"
db_character_four_lastname=""
db_character_four_signature="Hoot, Hoot! - What? i\'m an owl, what did you expect?"


#Character_five
db_character_five_user="Albus"
db_character_five_password="password123"
db_character_five_is_admin="TRUE"
db_character_five_firstname="Albus"
db_character_five_lastname="Dumbledore"
db_character_five_signature="It matters not what someone is born, but what they grow to be."


#Character_six
db_character_six_user="Severus"
db_character_six_password="password123"
db_character_six_is_admin="FALSE"
db_character_six_firstname="Severus"
db_character_six_lastname="Snape"
db_character_six_signature="I can teach you to bewitch the mind and ensnare the senses. I can tell you how to bottle fame, brew glory and even put a stopper in death."

#Character_seven
db_character_seven_user="Rubeus"
db_character_seven_password="password123"
db_character_seven_is_admin="FALSE"
db_character_seven_firstname="Rubeus"
db_character_seven_lastname="Hagrid"
db_character_seven_signature="You\'re a wizard, Harry."


#Webserver variables

SITE_NAME="Hogwarts"

WEBSITE_CREATED_BY="This website was created by Dobby the house elf. - 2023"

WELCOME="Welcome to the Hogwarts homepage, thank you for visiting our site."

CONTACT_EMAIL_ONE="Harry.Potter@hogwarts.ac.uk"
CONTACT_EMAIL_TWO="Hermione.Grainger@hogwarts.ac.uk"
CONTACT_EMAIL_THREE="Ron.Weasley@hogwarts.ac.uk"
CONTACT_EMAIL_FOUR="Hedwig@hogwarts.ac.uk"
CONTACT_EMAIL_FIVE="Albus.Dumbledore@hogwarts.ac.uk"
CONTACT_EMAIL_SIX="Severus.Snape@hogwarts.ac.uk"
CONTACT_EMAIL_SEVEN="Rubeus.Hagrid@hogwarts.ac.uk"

ABOUT_ONE="Hogwarts School of Witchcraft and Wizardry is a boarding school."
ABOUT_TWO="For young witches and wizards that was founded around the 9th and 10th century"
ABOUT_THREE="by Godric Gryffindor, Rowena Ravenclaw, Helga Hufflepuff and Salazar Slytherin."

#Secret keys

#Source code secret key (Zer0sh0ck Binary)
SECRET_FLAG_ONE="01011010 01100101 01110010 00110000 01110011 01101000 00110000 01100011 01101011"

#Secret directory secret key (L0gicB0mbe Hex)
SECRET_FLAG_TWO="0x4c 0x30 0x67 0x69 0x63 0x42 0x30 0x6d 0x62 0x65"

#SMB enumeration secret key (3301 base64)
SECRET_FLAG_THREE="MzMwMQ=="

#Shared drive key secret key (Petabyte octal)
SECRET_FLAG_FOUR="120 145 164 141 142 171 164 145 012"

#SQL injection secret key (Synergists decimal)
SECRET_FLAG_FIVE="83 121 110 101 114 103 105 115 116 115 10"

