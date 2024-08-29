<#
.SYNOPSIS
    Install "Apple Devices" -application

.DESCRIPTION
    This PowerShell-script will install "Apple Devices" -application using offline version of the installer.
    Installation will happens per user context.
    Installed application will be updated automatically from Microsoft Store if delivering software updates is not disabled.
    NOTE: You need to do some preparations before deploying this script. Please check preparation instructions from GitHub.

.VERSION
    1.0.0

.AUTHOR
    Jan Parttimaa (https://github.com/janparttimaa/apple-devices)

.COPYRIGHT
    © 2024 Jan Parttimaa. All rights reserved.

.LICENSE
    This script is licensed under the MIT License.
    You may obtain a copy of the License at https://opensource.org/licenses/MIT

.RELEASE NOTES
    1.0.0 - Initial release

.EXAMPLE
    powershell.exe -ExecutionPolicy Bypass -File .\install.ps1

    This example is how to run this script running Windows PowerShell. This is also the command that needs to be use when deploying it via Microsoft Configuration Manager.
#>

# Set Variables
$Installer = ".\AppleDevices.Msixbundle"
$ApplicationName = "Apple Devices"
$AppleDevices = Get-AppxPackage "AppleInc.AppleDevices"
$CorporateName = "Example Company"
$CorporateRegistryPath = "HKCU:\Software\$CorporateName"
$AppicationRegistryPath = "HKCU:\Software\$CorporateName\$ApplicationName"

# Checks if Apple Devices is installed. If not, it will be installed.
if ($AppleDevices) {
    Write-Host "Apple Devices is already installed. No need to reinstall it."
}else {
    Write-Host "Apple Devices not installed. Installing Apple Devices..."
    Add-AppPackage -Path $Installer -Wait -Verbose
}

Start-Sleep -Seconds 10 -Verbose

# Let's create registry key for Intune or Configuration Manager detection rule purposes and close the script
Write-Host "Creating registry key for Intune or Configuration Manager detection rule purposes..."
if (-not (Test-Path -Path $CorporateRegistryPath)) {
    New-Item -Path $CorporateRegistryPath -Force -Verbose
}else {
    Write-Host "Registry path '$CorporateRegistryPath' is already created. Let's continue..." 
}

if (-not (Test-Path -Path $AppicationRegistryPath)) {
    New-Item -Path $AppicationRegistryPath -Force -Verbose
}else {
    Write-Host "Registry path '$AppicationRegistryPath' is already created. Let's continue..." 
}

Set-ItemProperty -Path $AppicationRegistryPath -Name "ApplicationInstalled" -Value "Yes" -Type "String" -Force -Verbose
Set-ItemProperty -Path $AppicationRegistryPath -Name "ScriptVersion" -Value "1.0" -Type "String" -Force -Verbose

Start-Sleep -Seconds 10 -Verbose

Write-Host "Done. Closing script..."

Start-Sleep -Seconds 10 -Verbose