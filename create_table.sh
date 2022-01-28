#!/bin/bash
read -p "Enter Table Name: " table_name
 if [ `echo $table_name | wc -w` -eq 1 ]
 then
 if [ $((table_name)) != $table_name ] #check it is string or not
 then
 if [ -f ./databases/$connect_db/$table_name ] #check_existance
 then 
 echo "Table $table_name already exists!!"
 create_table.sh
 else
 declare -a values #array for fileds
 declare -a types #array for data types
 counter=0
 pkeycounter=-1

 echo "Please enter table fields and data types below!"
 while read -p "Field name: " var1
 do
 read -p "Data type (int or str): " var2 
 if [ $var2 = int -o $var2 = str ] #correct data type
 then
 if [ $pkeycounter -eq -1 ] #no pk inserted
 then
 read -p "do you wanna make this attribute primary key!?(y for yes n for no)" ans
 case $ans in
 [Yy]* ) values[$counter]+="$var1:"
         types[$counter]+="(p)$var2:"
         let pkeycounter=$counter 
         let counter=$counter+1
            ;;
 [Nn]* ) values[$counter]+="$var1:"
         types[$counter]+="$var2:"
         let counter=$counter+1  
            ;;
 *) echo "Please, press y or n"
    ;;
 esac
 else 
 values[$counter]+="$var1:"
 types[$counter]+="$var2:"
 let counter=$counter+1
 fi
 
 else 
 echo "Wrong data type!"
 fi
 done
 function pkey_fun {
 if [ $pkeycounter -eq -1 ]
 then
 echo "Ouch! You forgot to specify pkey! please select the index of your primary key: "
 echo ${values[@]}
 read x
 re='^[0-9]+$' 
 if [[ $x =~ $re && $x -le $counter ]] #check if index is integer and within values array range
 then  
 types[$x]="(p)${types[$x]}"
 let pkeycounter=$x
 else 
 echo " wrong index please try again! "
 pkey_fun
 fi
 fi
 }
 pkey_fun


touch ./databases/$connect_db/$table_name 
echo $counter >  ./databases/$connect_db/$table_name #number of columns
echo $pkeycounter >> ./databases/$connect_db/$table_name #pk index
printf %s "${types[@]}" $'\n' >> ./databases/$connect_db/$table_name
printf %s "${values[@]}" $'\n' >> ./databases/$connect_db/$table_name
echo "Your Table created Successfully"
./menu.sh 
 fi
 else
 echo "Table Name Must be a String"
 fi
 else
 echo "Please enter one argument!"
 fi