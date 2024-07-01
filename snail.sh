#!/bin/bash
#encrypt files with aes-256-cbc cipher using openssl

source "$(dirname -- "$(realpath -- "$0")")/style.sh"

function loading() {
    count=0
    total=10
    pstr="[=======================================================================]"

    while [ $count -lt $total ]; do
        sleep 0.5 # this is work
        count=$(( $count + 1 ))
        pd=$(( $count * 73 / $total ))
        printf "${Yellow}\r%3d.%1d%% %.${pd}s" $(( $count * 100 / $total )) $(( ($count * 1000 / $total) % 10 )) $pstr
    done
    echo "\n"
}
#create file
if [ $1 == "-c" ]; 
then
    if [ -e "$2.sec" ]; 
    then
        echo "File $2 already exists!"
    else
        echo >> "$2.sec"
        open -e "$2.sec"
    fi
#encrypt files
elif [ $1 == "-e" ];
then
    if [ -f "$2.sec" ];
    then
        openssl aes-256-cbc -a -e -salt -pbkdf2 -in "$2.sec" -pass env:SECRETS_PASS -out "$2.aes"
    else
       echo "${Red}This file does not exist!${Color_Off}" 
    fi
#decrypt files
elif [ $1 == "-d" ];
then
    if [ -f "$2.aes" ];
    then
        loading

        encrypted_file="$(<$2.aes)"
        decrypted=$( echo "${encrypted_file}" | openssl aes-256-cbc -a -d -salt -pbkdf2 -pass env:SECRETS_PASS)
        echo "${Green}$decrypted${Color_Off}"
        # openssl aes-256-cbc -a -d -salt -pbkdf2 -in "$2.aes" -out "$2.decrypt"
    else
        echo "${Red}This file does not exist!${Color_Off}" 
    fi
#decrypt for editing
elif [ $1 == "-de" ];
then
    if [ -f "$2.aes" ];
    then
        loading
        openssl aes-256-cbc -a -d -salt -pbkdf2 -in "$2.aes" -pass env:SECRETS_PASS -out "$2.sec"
        open -e "$2.sec"
    else
        echo "${Red}This file does not exist!${Color_Off}" 
    fi
# Delete all files with .sec extension
elif [ $1 == "-rm" ];
then
    find . -name "*.sec" -type f -delete
elif [ $1 == "-h" ];
then
    echo "This software uses openssl for encrypting files with the aes-256-cbc cipher"
    echo "Note: Password should be saved in ${IYellow}SECRETS_PASS${Color_Off} Environment, for more info refer to ${UBlue}https://phoenixnap.com/kb/zsh-environment-variables${Color_Off}"
    echo "Create a file: ${BCyan}./snail.sh${Color_Off} -c [file name] (file name without extension)"
    echo "Encrypting: ${BCyan}./snail.sh${Color_Off} -e [file name] (file name without extension)"
    echo "Decrypting: ${BCyan}./snail.sh${Color_Off} -d [file name] (file name without extension)"
    echo "Decrypting in file: ${BCyan}./snail.sh${Color_Off} -de [file name] (file name without extension)"
    echo "Removing decrypted file: ${BCyan}./snail.sh${Color_Off} -rm"
else
    echo "This action does not exist!"
    echo "Use ${BCyan}./snail.sh${Color_Off} -h to show help."
fi


