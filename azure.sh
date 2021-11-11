#!/bin/bash

location[1]="centralus"
#location[2]="uksouth"
#location[3]="ukwest"
#location[4]="australiasoutheast"
#location[5]="canadacentral"
#location[6]="southcentralus"
#location[7]="westcentralus"
#location[8]="eastus"
#location[9]="eastus2"
#location[10]="westus"
#location[11]="westus2"
#location[12]="koreacentral"
#location[13]="eastasia"
#location[14]="southeastasia"
#location[15]="norwayeast"
#location[16]="northeurope"
#location[17]="southafricanorth"
#location[18]="francecentral"
#location[19]="germanywestcentral"
#location[20]="koreasouth"
#location[21]="australiacentral"
#location[22]="australiaeast"
#location[23]="brazilsouth"

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

         #nome=$(date +"%d%m%Y%H%M%S")
         
         user=harvester$(printf %02d $i)
         
         nome=$user

         echo "Criando VM $nome ($i) na região $regiao da Subscription $assinatura com user $user"
         az vm create --location $regiao --resource-group $RG --name $nome --size "Standard_F8" --image UbuntuLTS --public-ip-sku Standard --accelerated-networking=true --authentication-type=password --admin-username=$user --admin-password=qpalzm794613Q! --data-disk-sizes-gb 512 512         

         CriandoVM=$(az vm list --query "[?name=='$nome'].{Nome:name}" -o tsv)     
         
         j=0
         while [ "$CriandoVM" != "$nome" ]
         do
           let "j++"
           sleep 1
           CriandoVM=$(az vm list --query "[?name=='$nome'].{Nome:name}" -o tsv)
           echo "Conectando na VM $nome ( tentativa $j )" 
         done
         
         echo "Conectado!"
         echo "Criando Extension da VM $nome na região $regiao da Subscription $assinatura"
         
         az vm extension set --publisher Microsoft.Azure.Extensions --version 2.0 --name CustomScript --vm-name $nome --resource-group $RG --settings '{"fileUris": ["https://raw.githubusercontent.com/harvester-services/sh/main/start.sh"],"commandToExecute":"./start.sh $user "}'
         echo
     
  done

done
