#Requires -version 3
Param()

$TCDIR = $Env:TWINCAT3DIR
$XAR_Root = $TCDIR.Substring(0,$TCDIR.Length-4)
$HMIControl = $XAR_Root+'Functions\TE2000-HMI-Engineering\References\EventVision.1.0.0.nupkg'

#Check if package was installed
if (Test-Path -Path $HMIControl)
{
    Remove-Item -Path $HMIControl -Force
}