#!/bin/bash
while true
do
echo
echo 1.Create database 
echo 2.List Databases
echo 3.Connect to Database
echo 4.Drop Database
echo echo -e "5.Exit \n"
read -p "Enter your choice: " choice
case $choice in
1). ./create_db.sh 
    ;;
2). ./list_db.sh
    ;;
3). ./connect_db.sh
    ;;
4). ./drop_database.sh
    ;;
5)break
    ;;
*) echo $choice is not a valid option
esac
done
