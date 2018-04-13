# AzureNestedHyperV
Create a Nested HyperV Host in Azure with one click

1. *Azure-deploy.json* – ARM template which will be called to run this provisioning
1. *InstallHyperV.ps1* – PowerShell script which will be called first and run using the PowerShell Custom Script extension
1. *HyperVHostConfig.ps1* (actually packaged as a zip file) – this is the PowerShell DSC script which will be run using the PowerShell DSC Script Extension.

Find more information on how to use this deployment <a href=https://buildazure.com/2018/04/10/nested-vms-in-azure-with-one-click-you-must-be-crazy>here</a>.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fdeltadan%2Fazurenestedhyperv%2Fmaster%2Fazure-deploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
