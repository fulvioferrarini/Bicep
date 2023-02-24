Set-Location '3. Complex'

$identifier = "complexx"
$rgName = "azws-bicep-$identifier-rg"
$appServicePlanName = "azws-bicep-$identifier-asp"
$websiteName = "azws-bicep-$identifier-web"
$appInsightsName = "azws-bicep-$identifier-ai"
$logAnalyticsName = "azws-bicep-$identifier-log"
$location = "westeurope"

az group create --name $rgName --location $location

# Deploy a bicep file
az deployment group create --resource-group $rgName `
  --name bicepDeployment --template-file appService.bicep `
  --parameters appServicePlanName=$appServicePlanName websiteName=$websiteName `
  appInsightsName=$appInsightsName logAnalyticsName=$logAnalyticsName --verbose

# clean
Set-Location ..

az group delete --name $rgName --yes --verbose
