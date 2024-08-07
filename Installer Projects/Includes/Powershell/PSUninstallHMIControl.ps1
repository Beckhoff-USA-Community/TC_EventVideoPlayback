#Requires -version 3
Param()

# Check Default 4026 Path
$HMIPkg = 'C:\ProgramData\Beckhoff\NuGetPackages\EventVision.1.0.0.nupkg'
if (Test-Path -Path $HMIPkg)
{
	# Delete the NuGet Packages
	Remove-Item -Path $HMIPkg
	Exit
}

# Check Default 4024 Path
$HMIPkg = 'C:\TwinCAT\Functions\TE2000-HMI-Engineering\References\EventVision.1.0.0.nupkg'
if (Test-Path -Path $HMIPkg)
{
	# Delete the NuGet Packages
	Remove-Item -Path $HMIPkg
	Exit
}

# Check Registry 4024 Path
$key = 'Registry::HKEY_CURRENT_USER\SOFTWARE\Beckhoff\TwinCAT3'
$TcDir = (Get-ItemProperty -Path $key -Name TwinCATDir).TwinCATDir
$HMIPkg = $TcDir+'Functions\TE2000-HMI-Engineering\References\EventVision.1.0.0.nupkg'
if (Test-Path -Path $HMIPkg)
{
	# Delete the NuGet Packages
	Remove-Item -Path $HMIPkg
	Exit
}