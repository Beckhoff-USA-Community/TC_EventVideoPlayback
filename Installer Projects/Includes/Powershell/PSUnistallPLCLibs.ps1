#Requires -version 3
Param()

$SPT_Base_Version="3.2.10"
$SPT_Event_Logger_Version="3.2.0"
$SPT_Vision_Version="3.0.4"


# Check Default 4024 location
if (Test-Path -Path "C:\TwinCAT\3.1\Components\Plc"){
    $RepToolLocations = @(Join-Path "C:\TwinCAT\3.1\Components\Plc\" "Common\RepTool.exe" -Resolve)
    if ($RepToolLocations.Length -gt 0) {
	    #Set the Reptool for use
	    $RepToolLocation = $RepToolLocations[$RepToolLocations.Length-1]
	    #Find the PLC Profiles
	    $plc_profiles = Get-ChildItem -Path "C:\TwinCAT\3.1\Components\Plc\Profiles" -Recurse -Name "*TwinCAT PLC Control_Build_*"
	    #Uninstall Libraries for each PLC Profile
	    foreach ($profile in $plc_profiles)
	    {
		    $rep_profile = (Get-Item "C:\TwinCAT\3.1\Components\Plc\Profiles\$profile").Basename
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
	
    }
    Exit
}

# Check Default 4026 location
if (Test-Path -Path "C:\Program Files (x86)\Beckhoff\TwinCAT\3.1\Components\Plc\"){
    $RepToolLocations = @(Join-Path "C:\Program Files (x86)\Beckhoff\TwinCAT\3.1\Components\Plc\Build_4026.*\" "Common\RepTool.exe" -Resolve)
    if ($RepToolLocations.Length -gt 0) {
	    $RepToolLocation = $RepToolLocations[$RepToolLocations.Length-1]
	    $index = $RepToolLocation.IndexOf("\Build_4026.")
	    $plcProfile = $RepToolLocation.Substring($index + 1)
	    $index = $plcProfile.IndexOf("\Common\RepTool.exe")
	    $plcProfile = $plcProfile.Substring(0, $index)
	    #Uninstall Base Types
	    $RepToolArgs = "--profile=`"TwinCAT PLC Control_$plcProfile`"", "--uninstallLib `"SPT Base Types, $SPT_Base_Version (Beckhoff Automation LLC)`""
	    Start-Process $RepToolLocation -ArgumentList $RepToolArgs -Wait -WindowStyle Hidden
	    #Uninstall Event Logger
	    $RepToolArgs = "--profile=`"TwinCAT PLC Control_$plcProfile`"", "--uninstallLib `"SPT Event Logger, $SPT_Event_Logger_Version (Beckhoff Automation LLC)`""
	    Start-Process $RepToolLocation -ArgumentList $RepToolArgs -Wait -WindowStyle Hidden
	    #Uninstall Vision
	    $RepToolArgs = "--profile=`"TwinCAT PLC Control_$plcProfile`"", "--uninstallLib `"SPT Vision, $SPT_Vision_Version (Beckhoff Automation LLC)`""
	    Start-Process $RepToolLocation -ArgumentList $RepToolArgs -Wait -WindowStyle Hidden
	
    }
    Exit
}



# Check Registry 4024 location
$key = 'Registry::HKEY_CURRENT_USER\SOFTWARE\Beckhoff\TwinCAT3'
$TcDir = (Get-ItemProperty -Path $key -Name TwinCATDir).TwinCATDir
if (Test-Path -Path $TcDir"3.1\Components\Plc\Common\RepTool.exe"){
    $RepToolLocations = @(Join-Path $TcDir"3.1\Components\Plc\" "Common\RepTool.exe" -Resolve)
    if ($RepToolLocations.Length -gt 0) {
	    #Set the Reptool for use
	    $RepToolLocation = $RepToolLocations[$RepToolLocations.Length-1]
	    #Find the PLC Profiles
	    $plc_profiles = Get-ChildItem -Path $TcDir"3.1\Components\Plc\Profiles" -Recurse -Name "*TwinCAT PLC Control_Build_*"
	    #Uninstall Libraries for each PLC Profile
	    foreach ($profile in $plc_profiles)
	    {
		    $rep_profile = (Get-Item $TcDir'3.1\Components\Plc\Profiles\'$profile).Basename
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
	
    }
    Exit
}


# Check Registry 4026 location
$key = 'Registry::HKEY_CURRENT_USER\SOFTWARE\Beckhoff\TwinCAT3'
$TcDir = (Get-ItemProperty -Path $key -Name TwinCATDir).TwinCATDir
if (Test-Path -Path $TcDir"3.1\Components\Plc\"){
    $RepToolLocations = @(Join-Path $TcDir"3.1\Components\Plc\Build_4026.*\" "Common\RepTool.exe" -Resolve)
    if ($RepToolLocations.Length -gt 0) {

	    $RepToolLocation = $RepToolLocations[$RepToolLocations.Length-1]
	    $index = $RepToolLocation.IndexOf("\Build_4026.")
	    $plcProfile = $RepToolLocation.Substring($index + 1)
	    $index = $plcProfile.IndexOf("\Common\RepTool.exe")
	    $plcProfile = $plcProfile.Substring(0, $index)
	    #Uninstall Base Types
	    $RepToolArgs = "--profile=`"TwinCAT PLC Control_$plcProfile`"", "--uninstallLib `"SPT Base Types, $SPT_Base_Version (Beckhoff Automation LLC)`""
	    Start-Process $RepToolLocation -ArgumentList $RepToolArgs -Wait -WindowStyle Hidden
	    #Uninstall Event Logger
	    $RepToolArgs = "--profile=`"TwinCAT PLC Control_$plcProfile`"", "--uninstallLib `"SPT Event Logger, $SPT_Event_Logger_Version (Beckhoff Automation LLC)`""
	    Start-Process $RepToolLocation -ArgumentList $RepToolArgs -Wait -WindowStyle Hidden
	    #Uninstall Vision
	    $RepToolArgs = "--profile=`"TwinCAT PLC Control_$plcProfile`"", "--uninstallLib `"SPT Vision, $SPT_Vision_Version (Beckhoff Automation LLC)`""
	    Start-Process $RepToolLocation -ArgumentList $RepToolArgs -Wait -WindowStyle Hidden
	
    }
    Exit
}
