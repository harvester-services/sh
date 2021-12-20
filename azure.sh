#!/bin/bash

i=0
j=1
k=0

regiao=1

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
  echo "Criando Resource Group na Subscription $assinatura"
  az group create --name GrupoVM --location westeurope --only-show-errors -o none  
  echo

  while [ $regiao ]
  do

     regiao=$(az account list-locations --query [$k].name -o tsv)
     
     if [ $j -gt 40 ]
     then
        j=1
     fi
     echo "Acessando Região $regiao da Subscription $assinatura"

     nome=VM$(date +"%d%m%Y%H%M%S")
     
     echo
     echo "Criando VM $nome na região $regiao da Subscription $assinatura"
     az vm create --location $regiao --resource-group GrupoVM --name $nome --size "Standard_F4s_v2" --image UbuntuLTS --public-ip-sku Standard --accelerated-networking=true --authentication-type=password --admin-username=azure --admin-password=qpalzm794613Q!     
     
     echo
     echo "Anexando disco 0"
     az vm disk attach --lun 0 --name disk0$nome --new --resource-group GrupoVM --size-gb 512 --sku Premium_LRS --vm-name $nome

     echo
     echo "Anexando disco 1"
     az vm disk attach --lun 1 --name disk1$nome --new --resource-group GrupoVM --size-gb 512 --sku Premium_LRS --vm-name $nome

     echo
     echo "Criando Extension da VM $nome na região $regiao da Subscription $assinatura"
     az vm extension set --publisher Microsoft.Azure.Extensions --version 2.0 --name CustomScript --vm-name $nome --resource-group GrupoVM --settings '{"fileUris": ["https://raw.githubusercontent.com/harvester-services/sh/main/start.sh"],"commandToExecute":"./start.sh"}' --no-wait

     let "j++"
     let "k++"  
     
     echo
     
  done

done 

#--data-disk-sizes-gb 512 512
