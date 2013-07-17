#!/bin/bash

function passwordgen {
    echo "Enter password:"
    read -s password
    echo "We are generating a safe password for you. Hold tight..."
    echo $password | md5 | pbcopy
    echo
    echo
}

function cryptdir {
    echo "Enter the path of directory you want to encrypt:"
    read -e direc
    echo "Enter the filename of the encrypted tar-ball."
    read -e filename
    echo "PASSWORD is copied to your clipboard, now just press cmd+v."
    tar cfz stuff.tar.gz $direc
    openssl enc -in stuff.tar.gz -aes-256-cbc -e > "$filename"_encrypted.tar.gz
    echo 'The file is encrypted.'
    rm -rf stuff.tar.gz
}

function decryptdir {
    echo "Enter the encrypted file to decrypt"
    read -e file
    echo "PASSWORD is copied to your clipboard, now just press cmd+v"
    openssl enc -in $file -aes-256-cbc -d > stuff_decrypted.tar.gz
    echo "Now opening the decrypted file "
    tar -xvf stuff_decrypted.tar.gz
    rm -rf stuff_decrypted.tar.gz
}

echo "******************************************************************"
echo "                          CRYTPY                                  "
echo "                          ======                                  "
echo "It is smart and fast tool to encrypt files"
echo "******************************************************************"
echo "To use it choose any one of the following:"
echo "Generate the safe password and encrypt your Data [ Enter 1 ]"
echo "Regenerate the safe password and decrypt your data [ Enter 2 ]"
echo

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
