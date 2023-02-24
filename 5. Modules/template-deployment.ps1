Set-Location '5. Modules'

$identifier = "modules"
$location = "westeurope"
$environmentTest = "test"
$environmentProd = "prod"
$rgTestName = "azrmt-bicep-$identifier-$environmentTest-rg"
$rgProdName = "azrmt-bicep-$identifier-$environmentProd-rg"

# params inline
az deployment sub create `
  --location $location `
  --name bicepModuleTest `
  --template-file main.bicep `
  --parameters environment=$environmentTest

az deployment sub create `
  --location $location `
  --name bicepModuleProd `
  --template-file main.bicep `
  --parameters environment=$environmentProd

# params file posh
New-AzDeployment -Location $location -Name bicepModuleTest -TemplateParameterFile "params.test.json" -TemplateFile "main.bicep" -Verbose

New-AzDeployment -Location $location -Name bicepModuleProd -TemplateParameterFile "params.prod.json" -TemplateFile "main.bicep" -Verbose

# clean
Set-Location ..

az group delete --name $rgTestName --yes
az group delete --name $rgProdName --yes
