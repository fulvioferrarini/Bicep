Set-Location '2. Compare'

$identifier = "compare"
$rgName = "azws-bicep-$identifier-rg"
$location = "westeurope"

# Build a ARM template from bicep
az bicep build --file template.bicep --outfile template.json

az group create --name $rgName --location $location --verbose

# Validate a bicep file
az deployment group validate --resource-group $rgName --name bicepDeployment --template-file template.bicep --verbose

# Deploy a bicep file
az deployment group create --resource-group $rgName --name bicepDeployment --template-file template.bicep --verbose

# clean
Set-Location ..

az group delete --name $rgName --yes --verbose
