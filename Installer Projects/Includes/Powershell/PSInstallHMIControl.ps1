#Requires -version 3
# -appdir "[APPDIR]HMI Control"
Param($appdir)
#Elevate to Administrator
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }


#Check if package was installed
if (Test-Path -Path $appdir)
{
	# Check Default 4026 Path
	$HMIPkg = 'C:\ProgramData\Beckhoff\NuGetPackages'
	if (Test-Path -Path $HMIPkg)
	{
		# Copy the NuGet Packages
		Copy-Item -Path $appdir'\*' -Destination $HMIPkg -Recurse
		Exit
	}

	# Check Default 4024 Path
	$HMIPkg = 'C:\TwinCAT\Functions\TE2000-HMI-Engineering\References'
	if (Test-Path -Path $HMIPkg)
	{
		# Copy the NuGet Packages
		Copy-Item -Path $appdir'\*' -Destination $HMIPkg -Recurse
		Exit
	}

	# Check Registry 4024 Path
	$key = 'Registry::HKEY_CURRENT_USER\SOFTWARE\Beckhoff\TwinCAT3'
	$TcDir = (Get-ItemProperty -Path $key -Name TwinCATDir).TwinCATDir
	$HMIPkg = $TcDir+'Functions\TE2000-HMI-Engineering\References'
	if (Test-Path -Path $HMIPkg)
	{
		# Copy the NuGet Packages
		Copy-Item -Path $appdir'\*' -Destination $HMIPkg -Recurse
		Exit
	}
}