#!/bin/bash

i=0
k=0

regiao=1

count=1
count1=1

a[$i]="Login ok!"

 while [ "${a[$i]}" ]
 do
    if [ "${a[$i]}" != "Login ok!" ]; then
       let "i++"
    fi

    a[$i]=$( az account list --all --query '['$i'].id' -o tsv)

    if [ "${a[$i]}" ]; then
       subscription[$i]=${a[$i]}
    fi
done

for assinatura in "${subscription[@]}"
 do
  echo
  echo "Set Subscription $assinatura"
  az account set --subscription $assinatura
  
  echo
  echo "Criando Resource Group da Subscription $assinatura"
  az group create --name GrupoLote --location westeurope --only-show-errors -o none
  echo  
  
  count2=1

  while [ $regiao ]
  do

     regiao=$(az account list-locations --query [$k].name -o tsv)

     nome=$(date +"%d%m%Y%H%M%S")

     let "perc= $(( $count * 100 / (${#regiao[@]} * ${#subscription[@]}) ))"

     echo "Criando Lote $nome $count2/${#regiao[@]} em $regiao da Subscription $assinatura $count1/${#subscription[@]}  > $perc% Concluído"
     az batch account create --resource-group GrupoLote --name $nome --location $regiao --only-show-errors -o none
     echo

     echo "Acessando Lote $nome $count2/${#regiao[@]} em $regiao da Subscription $assinatura $count1/${#subscription[@]}  > $perc% Concluído"
     az batch account login --resource-group GrupoLote --name $nome --shared-key-auth --only-show-errors -o none
     echo

     echo "Criando Pool no Lote $nome $count2/${#regiao[@]} em $regiao da Subscription $assinatura $count1/${#subscription[@]}  > $perc% Concluído"
     az batch pool create --json-file pool.json --only-show-errors -o none
     echo

     echo "Lote $nome $count2/${#regiao[@]} em $regiao da Subscription $assinatura $count1/${#subscription[@]} ok!  > $perc% Concluído"
     echo

     let "count++"
     let "count2++"

     let "k++"  
     
     echo
     
  done
  
  let "count1++"

done 
