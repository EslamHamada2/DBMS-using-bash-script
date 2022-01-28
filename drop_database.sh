#!/bin/bash
ls ./databases
read -p "Enter database Name that you want to drop: " dropped_db

 if [ `echo $dropped_db | wc -w` -eq 1 ] #check_no. arguments
 then
 if [ $((dropped_db)) != $dropped_db ] #string check
 then
 if [ -d ./databases/$dropped_db ] #check_existance
 then
 rm -r ./databases/$dropped_db 
 echo "Your database deleted successfully"
 else
 echo "Database not found! please enter a valid name!!"
 fi
 else
 echo "Database name must be a string"
 fi
 else
 echo "Please enter one argument!"
 fi