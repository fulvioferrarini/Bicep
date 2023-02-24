Set-Location '4. WhatIf'

$identifier = "whatif"
$rgName = "azws-bicep-${identifier}-rg"
$location = "westeurope"

az group create `
    --name $rgName `
    --location $location

az deployment group create `
    --resource-group $rgName `
    --template-file what-if-before.bicep

az deployment group what-if `
    --resource-group $rgName `
    --template-file what-if-after.bicep

# Confirm
az deployment group create `
    --resource-group $rgName `
    --mode Complete `
    --confirm-with-what-if `
    --template-file what-if-after.bicep

az deployment group create `
    --resource-group $rgName `
    --mode Complete `
    --confirm-with-what-if `
    --template-file empty.bicep

# clean
Set-Location ..

az group delete --name $rgName --yes
