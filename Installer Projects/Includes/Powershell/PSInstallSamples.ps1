#Requires -version 3
# -appdir "[APPDIR]Sample Project"
Param($appdir)

#Check if package was installed
if (Test-Path -Path $appdir)
{
	$TCDIR = $Env:TWINCAT3DIR
	$XAR_Root = $TCDIR.Substring(0,$TCDIR.Length-4)
	$Samples = $XAR_Root+'Functions\TcEventVideoPlayback'
	#Check if samples directory exists
	if (Test-Path -Path $Samples)
	{	
		# Copy the NuGet Packages
		Copy-Item -Path $appdir'\*' -Destination $Samples -Recurse -Force
	}
	else{
		# Create Direcotory if it doesnt exist
		New-Item -Type dir $Samples -Force
		Copy-Item -Path $appdir'\*' -Destination $Samples -Recurse -Force
	}
}