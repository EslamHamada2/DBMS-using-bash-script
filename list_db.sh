#!/bin/bash
if [ $(ls ./databases | wc -l) -gt 0 ] #check num of databases
then
ls ./databases
else
echo "No Databases found in the System!"

while true
do
read -p "Press y to create a new database or n to back to main menu: " value
case $value in
[Yy]* ). ./create_db.sh
    ;;
[Nn]* ) echo "You will be directed to the main menu"
    break;;
*) echo "Please, press y or n"
    ;;
esac
done
fi
