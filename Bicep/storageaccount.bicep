// bicep example
// you will need to compile this file into a Json ARM template using 'bicep build'
// notice we specify a symbolic name within the temlpate 'storageAccount' this can be referenced.
// resource type is simplified and now includes the api version
// all properties defined within the curly brackets

// parameters
@minLength(3)
@maxLength(24)
@description('Provide a name for the storage account. Use only lower case letters and numbers. The name must be unique across Azure.')
param storageAccountName string = 'demoBicep512' // this is a parameter with default value
param isProduction bool // boolean type parameter
param location string = resourceGroup().location // bicep functions

@secure()
param password string = 'test1234$'

// variables
var storageName = 'str${storageAccountName}' // this is concatination in bicep

// resources
resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: toLower(storageName) // string interpolation supported
  location: location // we can reference parameter directly.
  kind: 'Storage'
  sku: {
    name: isProduction ? 'Standard_GRS' : 'Standard_LRS' // check wheather production environment is 'true' and enable GRS for prod resource
  }
}
