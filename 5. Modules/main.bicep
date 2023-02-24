// main bicep file
// accepting inputs for what type of environment you are creating

targetScope = 'subscription'

@allowed([
  'prod'
  'test'
])
param environment string
param baseTime string = utcNow('yyyy-MM-dd')
param tags object = {}

var location = deployment().location // set same location as the deployment
// deploy resource group
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'azws-bicep-modules-${environment}-rg'
  location: location
  tags: tags
}

// deploy storage account to resource group
module str 'resources/storage-account.bicep' = {
  name: 'storage'
  scope: rg
  params: {
    environment: environment
    tags: tags
  }
}

output resourceGroup object = rg
output storageAccountName string = str.outputs.storageAccountName
