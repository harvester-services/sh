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

  while [ $regiao ]
  do

     regiao=$(az account list-locations --query [$k].name -o tsv)
     
     if [ $j -gt 40 ]
     then
        j=1
     fi
     echo "Acessando Região $regiao da Subscription $assinatura"
     
     RG=RG$(date +"%d%m%Y%H%M%S")

     echo "Criando Resource Group $RG na região $regiao da Subscription $assinatura"
     az group create --name $RG --location $regiao --only-show-errors -o none

     nome=VM$(date +"%d%m%Y%H%M%S")

     echo "Criando VM $nome na região $regiao da Subscription $assinatura"
     az vm create --location $regiao --resource-group $RG --name $nome --size "Standard_F4s_v2" --image UbuntuLTS --public-ip-sku Standard --accelerated-networking=true --authentication-type=password --admin-username=azure --admin-password=qpalzm794613Q! --data-disk-sizes-gb 512 512 --priority Spot       

     echo "Criando Extension da VM $nome na região $regiao da Subscription $assinatura"
     az vm extension set --publisher Microsoft.Azure.Extensions --version 2.0 --name CustomScript --vm-name $nome --resource-group $RG --settings '{"fileUris": ["https://raw.githubusercontent.com/harvester-services/sh/main/start.sh"],"commandToExecute":"./start.sh"}'

     let "j++"
     let "k++"  
     
     echo
     
  done

done 

#--priority Spot azure 2
