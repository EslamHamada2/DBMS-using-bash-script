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
pkey_index=`head -2 ./databases/$connect_db/$table_name | tail -1`
read -p "Please enter the primary key of the record you want to update!" input_pkey
let pkey_index=$pkey_index+1
r_num=$(awk -F: '{if (NR>4 && "'$input_pkey'"==$'$pkey_index')  print NR }' ./databases/$connect_db/$table_name)
if [ $((r_num)) -eq 0 ]
then
echo "primary key does not exist"
else

function update_field {
names=`head -4 ./databases/$connect_db/$table_name | tail -1`
col_names=($(echo "$names" | sed 's/:/ /g'))
echo ${col_names[@]} 
read -p "enter the field you want to update :" field
field_index=$(awk -F: '{if(NR==4){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' ./databases/$connect_db/$table_name)
old_value=$(awk -F: '{if(NR=="'$r_num'"){for(i=1;i<=NF;i++){if(i=="'$field_index'") print $i}}}' ./databases/$connect_db/$table_name)
read -p "enter the new value :" new_value
sed -i ''$r_num's/'$old_value'/'$new_value'/g' ./databases/$connect_db/$table_name
}
update_field
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
