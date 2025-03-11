> [!NOTE]  
> This repository has been archived 11 March 2025.<br>
> This archived repository is no longer developed and it is also set to read-only mode.

# Apple Devices
PowerShell-script that will install "Apple Devices" -application using offline version of the installer.

## Background
I created this PowerShell-script so I was able to deploy "Apple Devices" -application to dedicated and managed shared devices running Windows 11 or later that are only used for reinstalling iPhones and iPads. 

This script is suitable for corporate environments where you might have following situation:
- Your managed Windows-devices are running Windows 11 or later.
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
> [!NOTE]
> Make sure that you have adblocker turned on from your web browser. This is because site that we are using, shows very suspicious ads.
>
 
1. Copy this address: https://apps.microsoft.com/detail/9np83lwlpz9k?hl=en-us&gl=FI
2. Open [this site](https://store.rg-adguard.net/). Paste the address to this site and search in RP mode.
 
    ![Screenshot](/img/img%201.png)
3. Find the file that have ".msixbundle" -format. Click that to download it.
 
    ![Screenshot](/img/img%202.png)
     
> [!NOTE]
> Your browser might warn you for unsafe download. You can ingnore it and just download the file. Example from Microsoft Edge:
>  
> ![Screenshot](/img/img%203.png)   ![Screenshot](/img/img%204.png) 

4. Run the file on your antivirus-software just in case. If you don't get any warnings, file is then officially safe to use.
5. Rename the file to "AppleDevices". File should look like this:
 

    ![Screenshot](/img/img%205.png)
6. Add the installer to same folder where the installation script is. If you don't have folder, create one and put those two files to same folder.

### Add your corporate name to the installation script
Open the PowerShell-script to Visual Studio Code. From row number 37 you will see this variable: 
<pre>$CorporateName</pre>
This have placeholder called "**Example Company**". Replace the placeholder to your company name and safe the changes. For example, if your company name is "XYZ" script should look like this:

![Screenshot](/img/img%206.png)

## Deploy prepared script to specific devices via Configuration Manager as an application
> [!NOTE]
> Deploy script as "Required" so it will be automatically installed to device and their users.
>
For this example, we will deploy the script to specific devices at fictional company XYZ uisng Configuration Manager. Needed settings that needs to be configured are following:

![Screenshot](/img/img%207.png)
 
![Screenshot](/img/img%208.png)
 
![Screenshot](/img/img%209.png)
 
![Screenshot](/img/img%2010.png)
 
![Screenshot](/img/img%2011.png)
 
![Screenshot](/img/img%2012.png)
 
![Screenshot](/img/img%2013.png)
 
![Screenshot](/img/img%2014.png)
 
![Screenshot](/img/img%2015.png)
 
![Screenshot](/img/img%2016.png)
 
![Screenshot](/img/img%2017.png)
 
![Screenshot](/img/img%2018.png)

![Screenshot](/img/img%2019.png)

## Windows Update
When opening Apple Devices-app, app from laptop on Shared PC Mode without Guest Access, you need to temporarily allow Windows Update to download iPhone/iPad-drivers. Here is the workaround:
1. Sign in to device using your PC Admin -credentials.
2. Download scripts allow_windows_update_access.ps1 and block_windows_update_access.ps1 from GitHub.
3. Save the scripts to "C:\Temp"
4. Open "Apple Devices" -app and connect iPhone/iPad that needs to be re-installed using USB-cord.
5. Open PowerShell on your PC Admin -credentials and run following command inside "C:\Temp"-folder:<br>```powershell.exe -ExecutionPolicy Bypass -File .\allow_windows_update_access.ps1```

## Troubleshooting
If you have problems to execute one of the published scripts, please make sure that the script is unblocked from its file properties:
![Screenshot](/img/img%2020.png)
7. Open Windows Update from Settings and check updates. The drivers should be now downloaded and installed.
8. When all updates have been installed, open PowerShell on your PC Admin -credentials and run following command:<br>```powershell.exe -ExecutionPolicy Bypass -File .\block_windows_update_access.ps1```
9. Delete scripts from C:\Temp and Recycle Bin.
10. You can now use "Apple Devices" -app.
