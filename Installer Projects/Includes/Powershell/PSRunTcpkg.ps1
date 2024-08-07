#Requires -version 3
Param()

$timeoutSeconds = 20
$code = {
    $TcPkgCommand = "tcpkg install TwinCAT.XAE.PLC.Lib.Tc3_PackML_V2  --no-prompt"
    cmd.exe /c $TcPkgCommand
    Get-ChildItem *.cs | select name
}
$j = Start-Job -ScriptBlock $code
if (Wait-Job $j -Timeout $timeoutSeconds) { Receive-Job $j }
Remove-Job -force $j