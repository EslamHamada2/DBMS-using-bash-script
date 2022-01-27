#!/bin/bash
. ./list_tables.sh 
read -p "Enter Table Name: " table_name
if [ `echo $table_name | wc -w` -eq 1 ] 
then
if [ $((table_name)) != $table_name ]
then
if [ -f ./databases/$connect_db/$table_name ] #check_existance
then
declare -a input
input_index=0
flag=0
num_col=`head -1 ./databases/$connect_db/$table_name`
pkey_index=`head -2 ./databases/$connect_db/$table_name | tail -1`
str=`head -4 ./databases/$connect_db/$table_name | tail -1` #field names
str2=`head -3 ./databases/$connect_db/$table_name | tail -1` #data types
array=($(echo "$str" | sed 's/:/ /g'))
array2=($(echo "$str2" | sed 's/:/ /g'))
for el in "${array[@]}"; 
do
read -p "Enter $el of data type ${array2[$input_index]} :" user_input
if [ $input_index -eq $pkey_index ] #check primary key uniqueness
then
let y=$pkey_index+1
while true 
do
flag=$(awk -F: '{if ($'$y'=="'$user_input'")
print 1
}' ./databases/$connect_db/$table_name)
if [ $((flag)) -eq 0 ]  #pkey is unique
then
break
else  #pkey is  not unique
let flag=0
read -p "you entered a duplicate primary key! please enter a unique value :" user_input
fi
done
input[$input_index]="$user_input:"
let input_index=$input_index+1

else
input[$input_index]="$user_input:"
let input_index=$input_index+1
fi 

done

printf %s "${input[@]}" $'\n' >> ./databases/$connect_db/$table_name 
else 
echo "table doesn't exsist!"
fi
else
echo "Table Name Must be a String"
fi
else
echo "Please enter one argument!"
fi
