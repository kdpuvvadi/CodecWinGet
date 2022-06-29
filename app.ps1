# Import Scripts 
import-module ./lib/transcript.ps1
import-module ./lib/manifest.ps1

# Stop on error
$ErrorActionPreference = 'Stop'

# Start log
Start-Log

$WinGetPackage = "CodecGuide.K-LiteCodecPack"
$NevergreenPackage = "KLiteCodecPack"

$Channels = @(
    "Basic"
    "Standard"
    "Full"
    "Mega"
)
foreach ($Channel in $Channels) {
    $GetWinGetVersion = (WinGet show "$WinGetPackage.$Channel" | findstr -i Version).Substring(9)
    # Write-Output  "WinGet Version of $WinGetPackage.$Channel is $GetWinGetVersion"

    $GetLatestVersion = ((Get-NevergreenApp -Name $NevergreenPackage | Where-Object {$_.Channel -eq $Channel}).Version)
    # Write-Output "Latest Version of $WinGetPackage.$Channel is $GetLatestVersion"

    if ($GetWinGetVersion -lt $GetLatestVersion) {
        Write-Output "Update available"
        $GetLatestUri =  ((Get-NevergreenApp -Name $NevergreenPackage | Where-Object {$_.Channel -eq $Channel}).Uri)
        Write-Output $GetLatestUri
    }
    else {
        Write-Output "You've latest version installed"
    }
    Write-Output ""
}
 
