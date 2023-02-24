targetScope = 'subscription'

param name string

var location = 'westeurope'

resource myResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  location: location
  name: name
  tags: {
    owner: 'fulvioferrarini'
  }
}

module str 'storage-account.bicep' = {
  name: 'storage'
  scope: resourceGroup(myResourceGroup.name)
  params: {
    resourceGroupName: myResourceGroup.name
    storagePrefix: 'xrocketfhnw'
    storageSKU: 'Standard_LRS'
  }
}

output resourceGroupId string = myResourceGroup.id
