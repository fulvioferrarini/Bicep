// storage account module

param environment string
param tags object

var location = resourceGroup().location
var environmentSettings = {
  prod: {
    storageAccountName: toLower('strprod${uniqueString(resourceGroup().id)}') // concat prefix with a unique id. Make sure its in lower case.
    sku: 'Standard_GRS'
    publicAccess: false
  }
  test: {
    storageAccountName: toLower('strtest${uniqueString(resourceGroup().id)}') // concat prefix with a unique id. Make sure its in lower case.
    sku: 'Standard_LRS'
    publicAccess: true
  }
}

resource storage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: '${environmentSettings[environment].storageAccountName}' // use the name from our environment settings based on the inputed environment name
  location: location
  sku: {
    name: '${environmentSettings[environment].sku}'
  }
  kind: 'StorageV2'
  tags: tags
  properties: {
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: '${environmentSettings[environment].publicAccess}'
  }
}

output storageAccountName string = storage.name
