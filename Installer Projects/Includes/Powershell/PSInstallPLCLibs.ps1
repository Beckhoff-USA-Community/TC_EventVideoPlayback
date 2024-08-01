#Requires -version 3
# -appdir "[APPDIR]PLC Libraries"
Param($appdir)

#Check if package was installed
if (Test-Path -Path $appdir)
{
	# Find the RepTool location
	$RepToolLocation = Get-ChildItem $Env:TWINCAT3DIR -recurse -include "RepTool.exe"

	#Find the PLC Profiles
	$plc_profiles = Get-ChildItem -Path $Env:TWINCAT3DIR -Recurse -Name "*TwinCAT PLC Control_Build_*"

	#Install Libraries for each PLC Profile
	foreach ($profile in $plc_profiles)
	{
		$rep_profile = (Get-Item $Env:TWINCAT3DIR$profile).Basename
		$RepToolArgs = "--profile=`"$rep_profile`"", "--installLibsRecurs `"$appdir`""
		Start-Process $RepToolLocation -ArgumentList $RepToolArgs -Wait -WindowStyle Hidden
	}
}
