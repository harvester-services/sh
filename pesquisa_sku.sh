#/bin/bash

i=0
location=$0

while [ $location ]
do

 location=$(az account list-locations --query [$i].name -o tsv)

 result=$(az vm list-skus --location uk --size Standard_F8s_v2 --query [0].name -o tsv)

 if [ -n $result ]
 then
    echo $location
 fi

 let "i++"

done
