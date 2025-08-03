param location string = resourceGroup().location
param sqlServerName string
param sqlAdminUsername string
@secure()
param sqlAdminPassword string
param sqlDatabaseName string
param virtualNetworkName string
param subnetName string
param vpcName string

// Create SQL Server
resource sqlServer 'Microsoft.Sql/servers@2021-05-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlAdminUsername
    administratorLoginPassword: sqlAdminPassword
  }
}

// Create SQL Database
resource sqlDatabase 'Microsoft.Sql/servers/databases@2021-05-01-preview' = {
  parent: sqlServer
  name: sqlDatabaseName
  location: location
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 1073741824
  }
}

// Create Storage Account
param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

// Create Virtual Network
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}

// Create VPC (Virtual WAN)
resource vpc 'Microsoft.Network/virtualWans@2021-05-01' = {
  name: vpcName
  location: location
  properties: {
    allowBranchToBranchTraffic: true
    allowVnetToVnetTraffic: true
    disableVpnEncryption: false
  }
}

// Create Web App
resource webApp 'Microsoft.Web/sites@2021-01-15' = {
  name: 'yourWebAppName'
  location: location
  properties: {
    serverFarmId: '22331144'
    siteConfig: {
      alwaysOn: true
      vnetRouteAllEnabled: true
      // Ensure this property is valid for your configuration
       vnetFqdn: '${virtualNetwork.name}.vnet.local'
    }
    
      connectionStrings: [
      {
        name: 'yourConnectionStringName'
         type: 'SQLAzure'
        value: 'yourConnectionString'
       }
     ]
  }
}
