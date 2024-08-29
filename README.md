# Apple Devices
PowerShell-script that will install "Apple Devices" -application using offline version of the installer.

## Background
I created this PowerShell-script so I was able to deploy "Apple Devices" -application to dedicated and managed shared devices running Windows 10 or later that are only used for reinstalling iPhones and iPads. 

This script is suitable for corporate environments where you might have following situation:
- Your managed Windows-devices are running Windows 10 or later.
- Your managed Windows-devices are on [co-management](https://learn.microsoft.com/en-us/mem/configmgr/comanage/overview) so you are mananing these devices using Microsoft Intune and Microsoft Configuration Manager.
- Your company is not yet ready to switch [client apps deployment workload](https://learn.microsoft.com/en-us/mem/configmgr/comanage/how-to-switch-workloads) from Configuration Manager to Intune so you are still ddeploying managed applications to employees to Software Center.
- You are using [Shared PC mode](https://learn.microsoft.com/en-us/windows/configuration/shared-pc/shared-devices-concepts) on your shared Windows-devices.
- Your IT Helpdesk is using dedicated shared Windows-devices for iPhone and iPad reinstallations. So when employee has been resigned from your company, IT Helpdesk will reinstall employee's old work iPhone or iPad so it can be distribute to new employee.
- Your company has [blocked access to Microsoft Store](https://learn.microsoft.com/en-us/windows/configuration/store/?tabs=intune) so employees cannot install non-managed applications.
- Your company has [allowed automatic updates for apps from Microsoft Store](https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsStore::DisableAutoInstall) so, for example, pre-installed modern apps (e.g Calculator, Notepad, Paint, Photos) will be updated automatically even though Microsoft Store app is blocked.
- Your company has [allowed non-admins to install modern apps](https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.Appx::BlockNonAdminUserInstall) so for example installing Microsoft Teams automated and managed way is possible.
- You want to make sure that installed "Apple Devices" -application will be updated automatically through Microsoft Store when it will be installed using offline installation media.

## Preparation instructions
Before you deploy this PowerShell-script, you need to do some preparations.

### Get the offline media of the "Apple Devices" -application from Microsoft Store
TBA

### Add your corporate name to the installation script
TBA
