#!/bin/bash
read -p "Enter Database Name: " dbname
 if [ `echo $dbname | wc -w` -eq 1 ] #check number of arguments
 then
 if [ $((dbname)) != $dbname ] #check data type
 then
 if [ -d ./databases/$dbname ] #check_existance 
 then
 echo "Database $dbname already exists!!"
 else
 mkdir ./databases/$dbname 
 echo "You database created successfully"
 fi
 else
 echo "Database name must be a string"
 fi
 else
 echo "Please enter one argument!"
 fi