#!/bin/bash
. ./list_tables.sh 
read -p "Enter Table Name: " table_name
 if [ `echo $table_name | wc -w` -eq 1 ]
 then
 if [ $((table_name)) != $table_name ]
 then
 if [ -f ./databases/$connect_db/$table_name ] #check_existance
 then
 rm ./databases/$connect_db/$table_name 
 echo "Your Table deleted Successfully"
 else
 echo "Table not found! please enter a valid name!!"
 fi
 else
 echo "Table Name Must be a String"
 fi
 else
 echo "Please enter one argument!"
 fi