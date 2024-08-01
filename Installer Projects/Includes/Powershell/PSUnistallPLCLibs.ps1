#Requires -version 3
Param()

$SPT_Base_Version="3.2.10"
$SPT_Event_Logger_Version="3.2.0"
$SPT_Vision_Version="3.0.4"

# Find the RepTool location
$RepToolLocation = Get-ChildItem $Env:TWINCAT3DIR -recurse -include "RepTool.exe"

#Find the PLC Profiles
$plc_profiles = Get-ChildItem -Path $Env:TWINCAT3DIR -Recurse -Name "*TwinCAT PLC Control_Build_*"

#Install Libraries for each PLC Profile
foreach ($profile in $plc_profiles)
{
	$rep_profile = (Get-Item $Env:TWINCAT3DIR$profile).Basename
    #Uninstall Base Types
	$RepToolArgs = "--profile=`"$rep_profile`"", "--uninstallLib `"SPT Base Types, $SPT_Base_Version (Beckhoff Automation LLC)`""
	Start-Process $RepToolLocation -ArgumentList $RepToolArgs -Wait -WindowStyle Hidden
    #Uninstall Event Logger
	$RepToolArgs = "--profile=`"$rep_profile`"", "--uninstallLib `"SPT Event Logger, $SPT_Event_Logger_Version (Beckhoff Automation LLC)`""
	Start-Process $RepToolLocation -ArgumentList $RepToolArgs -Wait -WindowStyle Hidden
    #Uninstall Vision
	$RepToolArgs = "--profile=`"$rep_profile`"", "--uninstallLib `"SPT Vision, $SPT_Vision_Version (Beckhoff Automation LLC)`""
	Start-Process $RepToolLocation -ArgumentList $RepToolArgs -Wait -WindowStyle Hidden
}
