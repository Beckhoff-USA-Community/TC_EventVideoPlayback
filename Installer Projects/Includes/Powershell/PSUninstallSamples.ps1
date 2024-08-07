#Requires -version 3
Param()

#Elevate to Administrator
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }


$key = 'Registry::HKEY_CURRENT_USER\SOFTWARE\Beckhoff\TwinCAT3'
$TcDir = (Get-ItemProperty -Path $key -Name TwinCATDir).TwinCATDir
$Samples = $TcDir+'Functions\TcEventVideoPlayback'

#Check if package was installed
if (Test-Path -Path $Samples)
{
    Get-ChildItem -Path $Samples -Recurse | Remove-Item -recurse
    Remove-Item -Path $Samples
}