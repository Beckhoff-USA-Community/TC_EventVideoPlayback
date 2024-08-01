#Requires -version 3
Param()

$TCDIR = $Env:TWINCAT3DIR
$XAR_Root = $TCDIR.Substring(0,$TCDIR.Length-4)
$Samples = $XAR_Root+'Functions\TcEventVideoPlayback'

#Check if package was installed
if (Test-Path -Path $Samples)
{
    Get-ChildItem -Path $Samples -Recurse | Remove-Item -force -recurse
    Remove-Item -Path $Samples -Force
}