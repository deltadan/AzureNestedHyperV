<# 
Azure Nested VV Host Configuration
.File Name
 - HyperVHostConfig.ps1
 
.What calls this script?
 - This is a PowerShell DSC script called by azuredeploy.json

.What does this script do?  
 - Creates an Internal Switch in Hyper-V called "Nat Switch"
 - Creates a NAT Network on 192.168.0.0/24.  (All of your Nested VMs need static IPs on this network)
 - Add a new IP address to the Internal Network for Hyper-V attached to the NAT Switch

 There are also commented commands that you could use to automatically provision machines
 - Downloads an zipped VM to the local drive
 - Creates the Virtual Machine in Hyper-V
 - Issues a Start Command for the new Nested
#>

Configuration Main
{
	Param ( [string] $nodeName )

	Import-DscResource -ModuleName 'PSDesiredStateConfiguration', 'xHyper-V'

	node $nodeName
  	{
		# Ensures a VM with default settings
        xVMSwitch InternalSwitch
        {
            Ensure         = 'Present'
            Name           = 'Nat Switch'
            Type           = 'Internal'
        }
		
		Script ConfigureHyperV
    	{
			GetScript = 
			{
				@{Result = "ConfigureHyperV"}
			}	
		
			TestScript = 
			{
           		return $false
        	}	
		
			SetScript =
			{
				$NatSwitch = Get-NetAdapter -Name "vEthernet (NAT Switch)"
				New-NetIPAddress -IPAddress 192.168.0.1 -PrefixLength 24 -InterfaceIndex $NatSwitch.ifIndex
				New-NetNat -Name NestedVMNATnetwork -InternalIPInterfaceAddressPrefix 192.168.0.0/24 -Verbose
#				$zipDownload = "http://YOUR-URL-HERE/FILENAME.ZIP"
#				$downloadedFile = "D:\FILENAME.zip"
#				$vmFolder = "C:\VM"
#				Invoke-WebRequest $zipDownload -OutFile $downloadedFile
#				Add-Type -assembly "system.io.compression.filesystem"
#				[io.compression.zipfile]::ExtractToDirectory($downloadedFile, $vmFolder)
#				New-VM -Name VMNAME `
#					   -MemoryStartupBytes 2GB `
#					   -BootDevice VHD `
#					   -VHDPath 'C:\VM\PATH\FILENAME.vhd' `
#                      -Path 'C:\VM\PATH' `
#					   -Generation 1 `
#				       -Switch "NAT Switch"
#			    Start-VM -Name VMNAME
			}
		}	
  	}
}