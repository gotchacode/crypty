#!/bin/bash
#===============================================================================
#
#          FILE:  crypty.sh
# 
#         USAGE:  ./crypty.sh 
# 
#   DESCRIPTION: just a proof of concept for encrypting some files.Easy to use interface.
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  banner(for decoration)(*evil grin*)
#          BUGS:  please report if any.
#         NOTES:  ---
#        AUTHOR:  |Vinit Kumar| (), |vinitcool76@gmail.com|
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  Saturday 30 June 2012 11:12:03  IST IST
#      REVISION:  ---
#===============================================================================
BAD_CHOICE=87
   

function passwordgen {
echo "Enter a password you can remember"
read -s password
echo "Copy and paste the generated password---This password is not important for you to remember,Remember your original password"
echo -n "$password" | md5sum | awk '{print $1}'| md5sum | awk '{print $1}'

}

function cryptdir {

echo "Enter the directory you want to crypt"
read -e direc
tar cfz stuff.tar.gz $direc
openssl enc -in stuff.tar.gz -aes-256-cbc -e > stuff_encrypted.tar.gz
echo "The encripted file is stuff_encrypted.tar.gz"
}

function decryptdir {

echo "Name of the encrypted file to decrypt"
read -e file
openssl enc -in $file -aes-256-cbc -d > stuff_decrypted.tar.gz
echo "Now opening the decripted file "
tar -xvf stuff_decrypted.tar.gz
}


banner Crypty
echo "This script crypts and decrypts your sensitive information for you"
echo "Choose any one of these options"
echo "1.Create a safe password and encrypt your Data"
echo "2.Regenerate the safe password and decrypt your data"

read choice

case $choice in 
	1) crypt=1;;
	2) crypt=0;;
	*) echo "Wrong Choice" && exit $BAD_CHOICE;;

esac

if [ $crypt -ne 0 ];then 
	passwordgen && cryptdir
	 
else
	passwordgen && decryptdir
	
fi 


exit 0
