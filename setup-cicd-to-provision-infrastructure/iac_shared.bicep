@description('Application Name')
param applicationName string

@description('Application Short Name')
param applicationShortName string

@description('Location where resource has to be provision')
@allowed([
  'southeastasia'
  'uaenorth'
])
param location string

@description('Environment to be used for deployments')
@allowed([
  'demo'
  'nonprod'
])
param enviroment string

@description('Storage Account type')
@allowed([
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GRS'
  'Standard_GZRS'
  'Standard_LRS'
  'Standard_RAGRS'
  'Standard_RAGZRS'
  'Standard_ZRS'
])
param storageAccountType string = 'Standard_LRS'


var aspName = toLower('asp-${applicationName}-aen-${enviroment}')
var applicationInsightsName = toLower('ai-${applicationName}-aen-${enviroment}')
var funcAppName = toLower('aspw-${applicationName}-aen-${enviroment}')
var storageAccName = toLower('stlrs${applicationShortName}aen${enviroment}')


resource appInsightsComponents 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: applicationInsightsName
  location: location
  kind: 'web'
  tags: {
    enviroment: enviroment
  }
  properties: {
    Application_Type: 'web'
    SamplingPercentage: 100
  }
}


resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: aspName
  location: location
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
    size: 'Y1'
    family: 'Y'
    capacity: 1
  }
  kind: 'windows'
}

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccName
  location: location
  kind: 'StorageV2'
  sku: {
    name: storageAccountType
  }
}


resource azureFunction 'Microsoft.Web/sites@2020-12-01' = {
  name: funcAppName
  location: location
  kind: 'functionapp'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsDashboard'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccName};AccountKey=${listKeys(storageaccount.id, '2019-06-01').keys[0].value}'
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccName};AccountKey=${listKeys(storageaccount.id, '2019-06-01').keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccName};AccountKey=${listKeys(storageaccount.id, '2019-06-01').keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: toLower(funcAppName)
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~3'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsightsComponents.properties.InstrumentationKey
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'custom'
        }
      ]
    }
  }
  dependsOn: [
  ]
}
