#!/bin/bash
. ./list_tables.sh 
read -p "Enter Table Name: " table_name

if [ `echo $table_name | wc -w` -eq 1 ]
then
if [ $((table_name)) != $table_name ]
then
if [ -f ./databases/$connect_db/$table_name ] #check_existance
then
function menu {
while true
do
echo
echo 1.select all
echo 2.select column
echo 3.select record
echo -e "4.exit \n"
read -p "Enter your choice: " choice
case $choice in
1) selectall
    ;;
2) select_col
    ;;
3) select_record
    ;;
4)echo exit
    break;;
*) echo $choice is not a valid option
esac
done
}
else 
echo "table doesn't exsist!"
fi
else
echo "Table Name Must be a String"
fi
else
echo "Please enter one argument!"
fi


function selectall {
if [ `cat ./databases/$connect_db/$table_name | wc -l` -eq 3 ]
then
echo "This Table is empty"
else
awk -F: '{if (NR>3)
    print $0
  }' ./databases/$connect_db/$table_name
fi
 }
function select_col {
names=`head -4 ./databases/$connect_db/$table_name | tail -1`
col_names=($(echo "$names" | sed 's/:/ /g'))
counter=0
echo ${col_names[@]} 
read -p "Enter column name: " col_name
for el in "${col_names[@]}"; 
do
let counter=$counter+1 #index of input column
if [ $col_name = $el ] 
then
awk -F: '{if (NR>3) 
    print $'$counter'
  }' ./databases/$connect_db/$table_name
  break
elif [ $counter -eq ${#col_names[@]} ] 
then
echo "Column $col_name does not exist"
fi
done
 }


function select_record {
pkey_index=`head -2 ./databases/$connect_db/$table_name | tail -1`
read -p "Please enter the primary key of the record :" input_pkey
let y=$pkey_index+1
r_num=0
r_num=$(awk -F: '{if ($'$y'=="'$input_pkey'")
    print NR
  }' ./databases/$connect_db/$table_name)
# check if pkey doesnt exist
if [ $((r_num)) -eq 0 ]
then
echo "${col_names[$pkey_index]} does not exist"
else
awk  'BEGIN{FS=":"}{if (NR=="'$r_num'") 
    print $0
  }' ./databases/$connect_db/$table_name 
fi
}

menu