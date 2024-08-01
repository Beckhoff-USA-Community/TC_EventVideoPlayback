#Requires -version 3
# -appdir "[APPDIR]HMI Control"
Param($appdir)

#Check if package was installed
if (Test-Path -Path $appdir)
{
	$TCDIR = $Env:TWINCAT3DIR
	$XAR_Root = $TCDIR.Substring(0,$TCDIR.Length-4)
	$HMIPkg = $XAR_Root+'Functions\TE2000-HMI-Engineering\References'
	#Check if HMI directory exists
	if (Test-Path -Path $HMIPkg)
	{	
		# Copy the NuGet Packages
		Copy-Item -Path $appdir'\*' -Destination $HMIPkg -Recurse -Force
	}
}