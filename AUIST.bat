@echo off
echo Automated Update Integration and Streamlined Tool(AUIST)
echo Version: 0.1
echo Build: AUIST.v0.1.20240718.bat.2
echo Applicable Windows Version: Windows 10 19045.4651
echo ------------------------------------------------------------
echo 建立目錄
cd C:\
mkdir C:\org
mkdir C:\updates
mkdir C:\mount
mkdir C:\output
echo ------------------------------------------------------------
echo 請在C:\org放入原始映像
echo 請在C:\updates放入更新資料
echo ------------------------------------------------------------
pause
echo 掛載Windows 10 Pro (Index=3)
Dism /Mount-Image /ImageFile:C:\org\install.wim /index:3 /MountDir:C:\mount
echo ------------------------------------------------------------
echo 處理WinRE(winre.wim)
echo ------------------------------------------------------------
echo 處理WinRE-掛載winre.wim
mkdir C:\mount\winre
Dism /Mount-Wim /WimFile:C:\mount\Windows\System32\Recovery\Winre.wim /index:1 /MountDir:C:\mount\winre
echo ------------------------------------------------------------
echo 處理WinRE-新增SSU更新
Dism /Add-Package /Image:C:\mount\winre /PackagePath:"C:\updates\General\SSU_2023-10 Servicing Stack Update for Windows 10 Version 22H2 for x64-based Systems (KB5031539)"
echo ------------------------------------------------------------
echo 處理WinRE-新增服務堆疊動態更新
Dism /Add-Package /Image:C:\mount\winre /PackagePath:"C:\updates\WinRE\Security Updates_2024-07 Dynamic Cumulative Update for Windows 10 Version 22H2 for x64-based Systems (KB5040427)"
echo ------------------------------------------------------------
echo 處理WinRE-新增安全 OS 動態更新
Dism /Add-Package /Image:C:\mount\winre /PackagePath:"C:\updates\WinRE\Critical Updates_2024-01 Dynamic Update for Windows 10 Version 22H2 for x64-based Systems (KB5034232)"
echo ------------------------------------------------------------
echo 處理WinRE-進行映像清理
Dism /image:C:\mount\winre /cleanup-image /StartComponentCleanup /ResetBase
echo ------------------------------------------------------------
echo 處理WinRE-儲存WinRE映像變更
Dism /Unmount-Image /MountDir:"C:\mount\winre" /Commit
echo ------------------------------------------------------------
echo 處理WinRE-導出並取代舊有Winre.wim
Dism /Export-Image /SourceImageFile:C:\mount\Windows\System32\Recovery\winre.wim  /SourceIndex:1 /DestinationImageFile:"C:\output\19045_4651_build_20240718_v1_Winre.wim" /Compress:max /CheckIntegrity
del C:\mount\Windows\system32\recovery\winre.wim
copy C:\output\19045_4651_build_20240718_v1_Winre.wim C:\mount\Windows\system32\recovery\Winre.wim
echo ------------------------------------------------------------
echo 處理WinRE-移除WinRE掛載目錄
rmdir C:\mount\winre
echo ------------------------------------------------------------
echo 處理作業系統(install.wim)
echo ------------------------------------------------------------
echo 處理作業系統-移除不需要的Appx功能
echo Remove Appx-For Windows 10
Dism /Image:C:\mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.549981C3F5F10_1.1911.21713.0_neutral_~_8wekyb3d8bbwe
Dism /Image:C:\mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsMaps_2019.716.2316.0_neutral_~_8wekyb3d8bbwe
Dism /Image:C:\mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsFeedbackHub_2019.1111.2029.0_neutral_~_8wekyb3d8bbwe
Dism /Image:C:\mount /Remove-ProvisionedAppxPackage /PackageName:microsoft.windowscommunicationsapps_16005.11629.20316.0_neutral_~_8wekyb3d8bbwe
Dism /Image:C:\mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.SkypeApp_14.53.77.0_neutral_~_kzf8qxf38zg5c
Dism /Image:C:\mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.People_2019.305.632.0_neutral_~_8wekyb3d8bbwe
Dism /Image:C:\mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.Office.OneNote_16001.12026.20112.0_neutral_~_8wekyb3d8bbwe
Dism /Image:C:\mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.MixedReality.Portal_2000.19081.1301.0_neutral_~_8wekyb3d8bbwe
Dism /Image:C:\mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.MicrosoftStickyNotes_3.6.73.0_neutral_~_8wekyb3d8bbwe
Dism /Image:C:\mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.MicrosoftSolitaireCollection_4.4.8204.0_neutral_~_8wekyb3d8bbwe
Dism /Image:C:\mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.MicrosoftOfficeHub_18.1903.1152.0_neutral_~_8wekyb3d8bbwe
Dism /Image:C:\mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.Microsoft3DViewer_6.1908.2042.0_neutral_~_8wekyb3d8bbwe
Dism /Image:C:\mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.Getstarted_8.2.22942.0_neutral_~_8wekyb3d8bbwe
Dism /Image:C:\mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.GetHelp_10.1706.13331.0_neutral_~_8wekyb3d8bbwe
Dism /Image:C:\mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.BingWeather_4.25.20211.0_neutral_~_8wekyb3d8bbwe
echo ------------------------------------------------------------
echo 處理作業系統-啟用需要的Windows功能
Dism /Image:C:\mount  /Enable-Feature /FeatureName:VirtualMachinePlatform -All
Dism /Image:C:\mount  /Enable-Feature /FeatureName:HypervisorPlatform -All
Dism /Image:C:\mount  /Enable-Feature /FeatureName:Microsoft-Hyper-V-All -All
Dism /Image:C:\mount  /Enable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux -All
Dism /Image:C:\mount  /Enable-Feature /FeatureName:"Containers-DisposableClientVM" -All
echo ------------------------------------------------------------
echo 處理作業系統-新增SSU更新
Dism /Image:C:\mount /Add-Package /PackagePath:"C:\updates\General\SSU_2023-10 Servicing Stack Update for Windows 10 Version 22H2 for x64-based Systems (KB5031539)"
echo ------------------------------------------------------------
echo 處理作業系統-新增系統安全性及功能更新
Dism /Image:C:\mount /Add-Package /PackagePath:"C:\updates\System\安全性更新_2024-07 適用於 x64 系統 Windows 10 Version 22H2 的累積更新 (KB5040427)"
echo ------------------------------------------------------------
echo 處理作業系統-新增.NET更新
Dism /Image:C:\mount /Add-Package /PackagePath:"C:\updates\System\更新_Microsoft .NET Framework 4.8.1 for Windows 10 Version 22H2 for x64 (KB5011048)"
Dism /Image:C:\mount /Add-Package /PackagePath:"C:\updates\System\更新_2024-07 針對 x64 之 Windows 10 Version 22H2 的 .NET Framework 3.5、4.8 和 4.8.1 的累積更新 (KB5041019)"
echo ------------------------------------------------------------
echo 處理作業系統-檢查映像狀態
Dism /Image:C:\mount /Cleanup-Image /CheckHealth
echo ------------------------------------------------------------
echo 處理作業系統-進行映像清理
Dism /Image:C:\mount /Cleanup-Image /StartComponentCleanup /ResetBase
echo ------------------------------------------------------------
echo 處理作業系統-儲存映像變更
Dism /Unmount-Image /MountDir:C:\mount /Commit
echo ------------------------------------------------------------
echo 處理作業系統-導出處理完成映像(install.wim)
echo ------------------------------------------------------------
echo 處理作業系統-導出處理完成映像-install.wim
Dism /Export-Image /SourceImageFile:C:\org\install.wim /SourceIndex:3 /DestinationImageFile:"C:\output\19045_4651_build_20240718_v1_install.wim" /Compress:max /CheckIntegrity
echo ------------------------------------------------------------
rmdir C:\mount
echo ------------------------------------------------------------
echo 作業完成