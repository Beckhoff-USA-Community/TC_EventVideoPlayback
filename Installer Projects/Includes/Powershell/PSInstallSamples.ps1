#Requires -version 3
# -appdir "[APPDIR]Sample Project"
Param($appdir)
#Elevate to Administrator
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }


#Check if package was installed
if (Test-Path -Path $appdir)
{
	$key = 'Registry::HKEY_CURRENT_USER\SOFTWARE\Beckhoff\TwinCAT3'
	$TcDir = (Get-ItemProperty -Path $key -Name TwinCATDir).TwinCATDir
	$Samples = $TcDir+'Functions\TcEventVideoPlayback'
     #Check if samples directory exists
     if (Test-Path -Path $Samples)
     {	
         # Copy the NuGet Packages
         Copy-Item -Path $appdir'\*' -Destination $Samples -Recurse
     }
     else{
         # Create Direcotory if it doesnt exist
         New-Item -Type dir $Samples
         Copy-Item -Path $appdir'\*' -Destination $Samples -Recurse
     }
}