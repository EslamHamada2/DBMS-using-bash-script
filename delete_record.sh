#!/bin/bash
. ./list_tables.sh 
read -p "Enter Table Name: " table_name
if [ `echo $table_name | wc -w` -eq 1 ]
then
if [ $((table_name)) != $table_name ]
then
if [ -f ./databases/$connect_db/$table_name ] #check_existance
then
r_num=0
names=`head -4 ./databases/$connect_db/$table_name | tail -1`
col_names=($(echo "$names" | sed 's/:/ /g'))
pkey_index=`head -2 ./databases/$connect_db/$table_name | tail -1`
read -p "Please enter the primary key that you want to delete :" input_pkey
let y=$pkey_index+1 #pk index

r_num=$(awk 'BEGIN{FS=":"}{if ($'$y'=="'$input_pkey'")
    print NR
  }' ./databases/$connect_db/$table_name)

if [ $((r_num)) -eq 0 ]
then
echo "${col_names[$pkey_index]} does not exist"
. ./delete_record.sh
else
sed -i ''$r_num'd' ./databases/$connect_db/$table_name
fi
else 
echo "table doesn't exsist!"
fi
else
echo "Table Name Must be a String"
fi
else
echo "Please enter one argument!"
fi