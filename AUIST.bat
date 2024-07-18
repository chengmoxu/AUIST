@echo off
echo Automated Update Integration and Streamlined Tool(AUIST)
echo Version: 0.1
echo Build: AUIST.v0.1.20240718.bat.2
echo Applicable Windows Version: Windows 10 19045.4651
echo ------------------------------------------------------------
echo �إߥؿ�
cd C:\
mkdir C:\org
mkdir C:\updates
mkdir C:\mount
mkdir C:\output
echo ------------------------------------------------------------
echo �ЦbC:\org��J��l�M��
echo �ЦbC:\updates��J��s���
echo ------------------------------------------------------------
pause
echo ����Windows 10 Pro (Index=3)
Dism /Mount-Image /ImageFile:C:\org\install.wim /index:3 /MountDir:C:\mount
echo ------------------------------------------------------------
echo �B�zWinRE(winre.wim)
echo ------------------------------------------------------------
echo �B�zWinRE-����winre.wim
mkdir C:\mount\winre
Dism /Mount-Wim /WimFile:C:\mount\Windows\System32\Recovery\Winre.wim /index:1 /MountDir:C:\mount\winre
echo ------------------------------------------------------------
echo �B�zWinRE-�s�WSSU��s
Dism /Add-Package /Image:C:\mount\winre /PackagePath:"C:\updates\General\SSU_2023-10 Servicing Stack Update for Windows 10 Version 22H2 for x64-based Systems (KB5031539)"
echo ------------------------------------------------------------
echo �B�zWinRE-�s�W�A�Ȱ��|�ʺA��s
Dism /Add-Package /Image:C:\mount\winre /PackagePath:"C:\updates\WinRE\Security Updates_2024-07 Dynamic Cumulative Update for Windows 10 Version 22H2 for x64-based Systems (KB5040427)"
echo ------------------------------------------------------------
echo �B�zWinRE-�s�W�w�� OS �ʺA��s
Dism /Add-Package /Image:C:\mount\winre /PackagePath:"C:\updates\WinRE\Critical Updates_2024-01 Dynamic Update for Windows 10 Version 22H2 for x64-based Systems (KB5034232)"
echo ------------------------------------------------------------
echo �B�zWinRE-�i��M���M�z
Dism /image:C:\mount\winre /cleanup-image /StartComponentCleanup /ResetBase
echo ------------------------------------------------------------
echo �B�zWinRE-�x�sWinRE�M���ܧ�
Dism /Unmount-Image /MountDir:"C:\mount\winre" /Commit
echo ------------------------------------------------------------
echo �B�zWinRE-�ɥX�è��N�¦�Winre.wim
Dism /Export-Image /SourceImageFile:C:\mount\Windows\System32\Recovery\winre.wim  /SourceIndex:1 /DestinationImageFile:"C:\output\19045_4651_build_20240718_v1_Winre.wim" /Compress:max /CheckIntegrity
del C:\mount\Windows\system32\recovery\winre.wim
copy C:\output\19045_4651_build_20240718_v1_Winre.wim C:\mount\Windows\system32\recovery\Winre.wim
echo ------------------------------------------------------------
echo �B�zWinRE-����WinRE�����ؿ�
rmdir C:\mount\winre
echo ------------------------------------------------------------
echo �B�z�@�~�t��(install.wim)
echo ------------------------------------------------------------
echo �B�z�@�~�t��-�������ݭn��Appx�\��
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
echo �B�z�@�~�t��-�ҥλݭn��Windows�\��
Dism /Image:C:\mount  /Enable-Feature /FeatureName:VirtualMachinePlatform -All
Dism /Image:C:\mount  /Enable-Feature /FeatureName:HypervisorPlatform -All
Dism /Image:C:\mount  /Enable-Feature /FeatureName:Microsoft-Hyper-V-All -All
Dism /Image:C:\mount  /Enable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux -All
Dism /Image:C:\mount  /Enable-Feature /FeatureName:"Containers-DisposableClientVM" -All
echo ------------------------------------------------------------
echo �B�z�@�~�t��-�s�WSSU��s
Dism /Image:C:\mount /Add-Package /PackagePath:"C:\updates\General\SSU_2023-10 Servicing Stack Update for Windows 10 Version 22H2 for x64-based Systems (KB5031539)"
echo ------------------------------------------------------------
echo �B�z�@�~�t��-�s�W�t�Φw���ʤΥ\���s
Dism /Image:C:\mount /Add-Package /PackagePath:"C:\updates\System\�w���ʧ�s_2024-07 �A�Ω� x64 �t�� Windows 10 Version 22H2 ���ֿn��s (KB5040427)"
echo ------------------------------------------------------------
echo �B�z�@�~�t��-�s�W.NET��s
Dism /Image:C:\mount /Add-Package /PackagePath:"C:\updates\System\��s_Microsoft .NET Framework 4.8.1 for Windows 10 Version 22H2 for x64 (KB5011048)"
Dism /Image:C:\mount /Add-Package /PackagePath:"C:\updates\System\��s_2024-07 �w�� x64 �� Windows 10 Version 22H2 �� .NET Framework 3.5�B4.8 �M 4.8.1 ���ֿn��s (KB5041019)"
echo ------------------------------------------------------------
echo �B�z�@�~�t��-�ˬd�M�����A
Dism /Image:C:\mount /Cleanup-Image /CheckHealth
echo ------------------------------------------------------------
echo �B�z�@�~�t��-�i��M���M�z
Dism /Image:C:\mount /Cleanup-Image /StartComponentCleanup /ResetBase
echo ------------------------------------------------------------
echo �B�z�@�~�t��-�x�s�M���ܧ�
Dism /Unmount-Image /MountDir:C:\mount /Commit
echo ------------------------------------------------------------
echo �B�z�@�~�t��-�ɥX�B�z�����M��(install.wim)
echo ------------------------------------------------------------
echo �B�z�@�~�t��-�ɥX�B�z�����M��-install.wim
Dism /Export-Image /SourceImageFile:C:\org\install.wim /SourceIndex:3 /DestinationImageFile:"C:\output\19045_4651_build_20240718_v1_install.wim" /Compress:max /CheckIntegrity
echo ------------------------------------------------------------
rmdir C:\mount
echo ------------------------------------------------------------
echo �@�~����