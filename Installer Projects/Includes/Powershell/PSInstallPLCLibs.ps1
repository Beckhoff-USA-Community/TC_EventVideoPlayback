#Requires -version 3
# -appdir "[APPDIR]PLC Libraries"
Param($appdir)

# Check that the folders were installed on the disk
if (Test-Path -Path $appdir)
{

	# Check Default 4024 location
    if (Test-Path -Path "C:\TwinCAT\3.1\Components\Plc"){
	    $RepToolLocations = @(Join-Path "C:\TwinCAT\3.1\Components\Plc\" "Common\RepTool.exe" -Resolve)
	    if ($RepToolLocations.Length -gt 0) {
		    #Set the Reptool for use
		    $RepToolLocation = $RepToolLocations[$RepToolLocations.Length-1]
		    #Find the PLC Profiles
		    $plc_profiles = Get-ChildItem -Path "C:\TwinCAT\3.1\Components\Plc\Profiles\" -Recurse -Name "*TwinCAT PLC Control_Build_*"
		    #Install Libraries for each PLC Profile
		    foreach ($profile in $plc_profiles)
		    {
			    $rep_profile = (Get-Item "C:\TwinCAT\3.1\Components\Plc\Profiles\$profile").Basename
			    $RepToolArgs = "--profile=`"$rep_profile`"", "--installLibsRecurs `"$appdir`""
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
		    $RepToolArgs = "--profile=`"TwinCAT PLC Control_$plcProfile`"", "--installLibsRecurs `"$appdir`""
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
		    #Install Libraries for each PLC Profile
		    foreach ($profile in $plc_profiles)
		    {
			    $rep_profile = (Get-Item $TcDir'3.1\Components\Plc\Profiles\'$profile).Basename
			    $RepToolArgs = "--profile=`"$rep_profile`"", "--installLibsRecurs `"$appdir`""
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
		    $RepToolArgs = "--profile=`"TwinCAT PLC Control_$plcProfile`"", "--installLibsRecurs `"$appdir`""
		    Start-Process $RepToolLocation -ArgumentList $RepToolArgs -Wait -WindowStyle Hidden	
	    }
        Exit
    }

}