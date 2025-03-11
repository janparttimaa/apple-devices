<#
.SYNOPSIS
    Block direct Windows Update -access for devices managed by Configuration Manager (SCCM) after temporary allowing access.

.DESCRIPTION
    This PowerShell-script blocks direct Windows Update -access for devices managed by Configuration Manager (SCCM) after temporary allowing access.
    Scope of this script: Corporate environments only.
    Platform: Windows 10 and later.
    NOTE: Please check instructions from GitHub before running this script.

.VERSION
    1.0.0

.AUTHOR
    Jan Parttimaa (https://github.com/janparttimaa/apple-devices)

.COPYRIGHT
    © 2025 Jan Parttimaa. All rights reserved.

.LICENSE
    This script is licensed under the MIT License.
    You may obtain a copy of the License at https://opensource.org/licenses/MIT

.RELEASE NOTES
    1.0.2 - Initial release and aligning release versio numbering with the installation script.

.EXAMPLE
    powershell.exe -ExecutionPolicy Bypass -File .\block_windows_update_access.ps1
    This example is how to run this script running Windows PowerShell. You need to run this script with your admin rights.
#>

# Blocking Windows Update
Write-Host "Blocking Windows Update access..."
if (Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name DeferFeatureUpdatesPeriodInDays -Verbose -ErrorAction SilentlyContinue) {Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name DeferFeatureUpdatesPeriodInDays -Force -Verbose -ErrorAction SilentlyContinue}
if (Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name SetDisableUXWUAccess -Verbose -ErrorAction SilentlyContinue) {Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name SetDisableUXWUAccess -Force -Verbose -ErrorAction SilentlyContinue}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name DisableWindowsUpdateAccess -Value 1 -Verbose -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "UseWUServer" -Value 1 -Verbose -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name SetPolicyDrivenUpdateSourceForDriverUpdates -Value 0 -Verbose -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name SetPolicyDrivenUpdateSourceForFeatureUpdates -Value 1 -Verbose -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name SetPolicyDrivenUpdateSourceForOtherUpdates -Value 1 -Verbose -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name SetPolicyDrivenUpdateSourceForQualityUpdates -Value 1 -Verbose -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name UseUpdateClassPolicySource  -Value 1 -Verbose -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\GPCache\CacheSet001\WindowsUpdate" -Recurse -Force -Verbose -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\GPCache\CacheSet002\WindowsUpdate" -Recurse -Force -Verbose -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\GPCache\CacheSet001\WindowsUpdate" -Verbose -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\GPCache\CacheSet001\WindowsUpdate\AU" -Verbose -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\GPCache\CacheSet002\WindowsUpdate" -Verbose -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\GPCache\CacheSet002\WindowsUpdate\AU" -Verbose -ErrorAction SilentlyContinue

# Restart services
Restart-Service wuauserv -Verbose
Start-Sleep -Seconds 10
Write-Host "Windows Update is now blocked again. Closing script..."
Start-Sleep -Seconds 2
