#!/usr/bin/env bash


#CTF Machine details

HOSTNAME="ACME.INC"
IP="10.0.20.4"
GATEWAY_IP=""

#character information for the user creation.
character_one="Bugs"
character_two="Lola"
character_three="Daffy"
character_four="Road_Runner"
character_five="Porky"
character_six="Wile_E"
character_seven="Foghorn"

password_one='password123'
password_two='password123'
password_three='password123'
password_four='password123'
password_five='password123'
password_six='password123'
password_seven='password123'

#Here is the Database information variables

#Character_one

db_character_one_user="Bugs"
db_character_one_password="password123"
db_character_one_is_admin="FALSE"
db_character_one_firstname="Bugs"
db_character_one_lastname="Bunny"
db_character_one_signature="Eh, What\'s up doc?"

#Character_two#

db_character_two_user="Lola"
db_character_two_password="password123"
db_character_two_is_admin="FALSE"
db_character_two_firstname="Lola"
db_character_two_lastname="Bunny"
db_character_two_signature="Don't ever call me \'Doll."


#Character_three
db_character_three_user="Daffy"
db_character_three_password="password123"
db_character_three_is_admin="FALSE"
db_character_three_firstname="Daffy"
db_character_three_lastname="Duck"
db_character_three_signature="I think you\'re pretty tough don\'t I?"

#Character_four
db_character_four_user="Road"
db_character_four_password="password123"
db_character_four_is_admin="FALSE"
db_character_four_firstname="Road"
db_character_four_lastname="Runner"
db_character_four_signature="Meep! Meep!"


#Character_five
db_character_five_user="Porky"
db_character_five_password="password123"
db_character_five_is_admin="FALSE"
db_character_five_firstname="Porky"
db_character_five_lastname="Pig"
db_character_five_signature="That\'s all folks!"


#Character_six
db_character_six_user="Wile_E"
db_character_six_password="password123"
db_character_six_is_admin="TRUE"
db_character_six_firstname="Wile E"
db_character_six_lastname="Coyote"
db_character_six_signature="*HOLDS UP A SIGN WITH THE WORDS \'HELP\'*."

#Character_seven
db_character_seven_user="Foghorn"
db_character_seven_password="password123"
db_character_seven_is_admin="FALSE"
db_character_seven_firstname="Foghorn"
db_character_seven_lastname="Leghorn"
db_character_seven_signature="I looka, I say, looka here."


#Webserver variables
SITE_NAME="ACME Factory"

WEBSITE_CREATED_BY="This website was created by the Tasmanian Devil - 2023"

WELCOME="Welcome to the ACME factories webpage, thank you for visiting our site."

CONTACT_EMAIL_ONE="Bugs@ACME-factory.com"
CONTACT_EMAIL_TWO="Lola@ACME-factory.com"
CONTACT_EMAIL_THREE="Daffy@ACME-factory.com"
CONTACT_EMAIL_FOUR="Road@ACME-factory.com"
CONTACT_EMAIL_FIVE="Porky@ACME-factory.com"
CONTACT_EMAIL_SIX="Wile_E@ACME-factory.com"
CONTACT_EMAIL_SEVEN="Foghorn@ACME-factory.com"

ABOUT_ONE="The ACME factory specialises in the creation a wide range of"
ABOUT_TWO="products ranging from rockets to rather heavy pianos. "
ABOUT_THREE="Our key shareholder is Wile.E Coyote."

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


root@Hogwarts:/home/admin_account#
root@Hogwarts:/home/admin_account# cat Chocolate_factory_variables.sh
#!/usr/bin/env bash

#CTF Machine details

HOSTNAME="Chocolate_Factory"
IP="10.0.20.4"
GATEWAY_IP=""

#character information for the user creation.
character_one="Willy"
character_two="Charlie"
character_three="Grandpa"
character_four="William"
character_five="Hellen"
character_six="Oompa_Lompa"
character_seven="Squrriel"

password_one='password123'
password_two='password123'
password_three='password123'
password_four='password123'
password_five='password123'
password_six='password123'
password_seven='password123'

#Here is the Database information variables

#Character_one

db_character_one_user="Willy"
db_character_one_password="password123"
db_character_one_is_admin="TRUE"
db_character_one_firstname="Willy"
db_character_one_lastname="Wonka"
db_character_one_signature="I, Willy Wonka, have decided to allow five children - just five, mind you, and no more - to visit my factory this year."

#Character_two#

db_character_two_user="Charlie"
db_character_two_password="password123"
db_character_two_is_admin="FALSE"
db_character_two_firstname="Charlie"
db_character_two_lastname="Bucket"
db_character_two_signature="I\'m here to try and win the Golden Ticket, sir."


#Character_three
db_character_three_user="Grandpa"
db_character_three_password="password123"
db_character_three_is_admin="FALSE"
db_character_three_firstname="Grandpa"
db_character_three_lastname="Joe"
db_character_three_signature="I/'ve heard that what you imagine sometimes comes true."

#Character_four
db_character_four_user="William"
db_character_four_password="password123"
db_character_four_is_admin="FALSE"
db_character_four_firstname="William"
db_character_four_lastname="Bucket"
db_character_four_signature="Well, I/'m Charlies dad."


#Character_five
db_character_five_user="Hellen"
db_character_five_password="password123"
db_character_five_is_admin="FALSE"
db_character_five_firstname="Hellen"
db_character_five_lastname="Bucket"
db_character_five_signature="And i/'m Charlies mum."


#Character_six
db_character_six_user="Ommpa_Loompa"
db_character_six_password="password123"
db_character_six_is_admin="TRUE"
db_character_six_firstname="Oompa"
db_character_six_lastname="Loompa"
db_character_six_signature="Oompa loompa doompety doo."

#Character_seven
db_character_seven_user="Squirrel"
db_character_seven_password="password123"
db_character_seven_is_admin="FALSE"
db_character_seven_firstname="Squirrel"
db_character_seven_lastname=""
db_character_seven_signature="Squeak!"


#Webserver variables
SITE_NAME="Willy Wonka's Chocolate Factory"

WEBSITE_CREATED_BY="This website was created by an Ommpa Loompa. - 2023"

WELCOME="Welcome to the chocolate factories webpage, thank you for visiting our site."

CONTACT_EMAIL_ONE="Willy@chocolate-factory.co.uk"
CONTACT_EMAIL_TWO="Charlie@chocolate-factory.co.uk"
CONTACT_EMAIL_THREE="Grandpa@chocolate-factory.co.uk"
CONTACT_EMAIL_FOUR="William@chocolate-factory.co.uk"
CONTACT_EMAIL_FIVE="Hellen@chocolate-factory.co.uk"
CONTACT_EMAIL_SIX="Ommpa_Loompa@chocolate-factory.co.uk"
CONTACT_EMAIL_SEVEN="Squirrel@chocolate-factory.co.uk"

ABOUT_ONE="Willy Wonka's chocolate factory was founded by Willy Wonka"
ABOUT_TWO="with the aim of creating magical chocolate treats and sweets"
ABOUT_THREE="with assistance from a few Oompa Loompas."

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
