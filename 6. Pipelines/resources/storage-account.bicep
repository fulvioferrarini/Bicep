@minLength(3)
@maxLength(11)
param storagePrefix string = 'testprefix'

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
])
param storageSKU string = 'Standard_LRS'

@description('Targeted resourcegroup')
param resourceGroupName string = 'testbicep-rg'

var uniqueStorageName = '${storagePrefix}${uniqueString(myResourceGroup.id)}'

resource myResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: resourceGroupName
  scope: subscription()
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: uniqueStorageName
  location: resourceGroup().location
  sku: {
    name: storageSKU
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
  tags: {
    owner: 'fulvioferrarini'
    costcenter: '42'
    env: 'dev'
  }
}

resource lockStorageAccount 'Microsoft.Authorization/locks@2017-04-01' = {
  name: 'stoLock'
  properties: {
    level: 'CanNotDelete'
  }
  scope: storageAccount
}

output storageEndpoint object = storageAccount.properties.primaryEndpoints
