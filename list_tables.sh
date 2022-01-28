#!/bin/bash
if [ $(ls ./databases/$connect_db | wc -l) -gt 0 ]
then
ls ./databases/$connect_db 
else
echo "No Tables found in the System!"
while true
do
read -p "Press y to create a new Table or n to back to the previous menu: " value
case $value in
[Yy]* ). ./create_table.sh
    ;;
[Nn]* ) echo "You will be directed to the previous menu"
    break;;
*) echo "Please, press y or n"
    ;;
esac
done
fi