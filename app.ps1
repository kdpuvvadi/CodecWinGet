# Logs
$logDir = "$PWD\logs"
$logMessage = "The log dir doesn't exist. This dir will be used for storing logs."
If (Test-Path $logDir) {
    Write-Output "$logDir exists. Skipping."
}
Else {
    Write-Output $logMessage
    Start-Sleep 1
    New-Item -Path "$logDir" -ItemType Directory
    Write-Output "The log Dir was successfully created." `n
    Start-Sleep 1
}
$logfile = Get-Date -Format "ddMMyy_hhmm"
$logfilepath =  "$logDir\log_$logfile.log"
Start-Transcript -path $logfilepath -IncludeInvocationHeader -Append
Write-Output ""

$PackageName = "CodecGuide.K-LiteCodecPack"

$Channels = @(
    "Basic"
    "Standard"
    "Full"
    "Mega"
)
foreach ($Channel in $Channels) {
    $GetWinGetVersion = (WinGet show "$PackageName.$Channel" | findstr -i Version).Substring(9)
    # Write-Output  "WinGet Version of $PackageName.$Channel is $GetWinGetVersion"

    $GetLatestVersion = ((Get-NevergreenApp -Name KLiteCodecPack | Where-Object {$_.Channel -eq $Channel}).Version)
    # Write-Output "Latest Version of $PackageName.$Channel is $GetLatestVersion"

    if ($GetWinGetVersion -lt $GetLatestVersion) {
        Write-Output "Update available"
        $GetLatestUri =  ((Get-NevergreenApp -Name KLiteCodecPack | Where-Object {$_.Channel -eq $Channel}).Uri)
        Write-Output $GetLatestUri
    }
    else {
        Write-Output "You've latest version installed"
    }
    Write-Output ""
}
 
