#!/bin/bash

location=$(az account list-locations --query [*].name -o tsv)

 #az account clear
 #az login -o table 

i=0

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

  for regiao in "${location[@]}"
   do
     echo "Acessando Região $regiao da Subscription $assinatura"
     
     RG=RG$(date +"%d%m%Y%H%M%S")

     echo "Criando Resource Group $RG na região $regiao da Subscription $assinatura"
     az group create --name $RG --location $regiao --only-show-errors -o none
         
     user=harvester$(printf %02d $i)
         
     #nome=$user
     nome=$(date +"%d%m%Y%H%M%S")

     echo "Criando VM $nome ($i) na região $regiao da Subscription $assinatura com user $user"
     az vm create --location $regiao --resource-group $RG --name $nome --size "Standard_F8" --image UbuntuLTS --public-ip-sku Standard --accelerated-networking=true --authentication-type=password --admin-username=$user --admin-password=qpalzm794613Q! --data-disk-sizes-gb 512 512         

     echo "Criando Extension da VM $nome na região $regiao da Subscription $assinatura"
         
     az vm extension set --publisher Microsoft.Azure.Extensions --version 2.0 --name CustomScript --vm-name $nome --resource-group $RG --settings '{"fileUris": ["https://raw.githubusercontent.com/harvester-services/sh/main/start.sh"],"commandToExecute":"./start.sh"}'
     echo
     
  done

done
