# Snail

Script to encrypt decrypt files with ssl & salt

![Static Badge](https://img.shields.io/badge/license-Apach-red) ![Static Badge](https://img.shields.io/badge/Platforms-MacOS%20%7C%20Linux-red)



## Script usage
Note: use only file name without any extension, to use password properly through environments follow instructions here [zsh-environment-variables](https://phoenixnap.com/kb/zsh-environment-variables)
- Create file & opens in text editor
  
   `./snail.sh -c my_file`
- Encrypt file and save

   `./snail.sh -e my_file`
- Decrypt file in consol

   `./snail.sh -d my_file`
- Decrypt file and open in default editor

   `./snail.sh -d my_file`
- After ensuring all files are encrypted and saved, execute removal script

   `./snail.sh -rm`
- You can always call for help

   `./snail.sh -h`
