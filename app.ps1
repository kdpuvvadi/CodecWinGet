# Import Scripts 
. ./lib/transcript.ps1

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
    Write-Output "Retrieving WinGet version of $WinGetPackage.$Channel"
    $GetWinGetVersion = (WinGet show "$WinGetPackage.$Channel" | findstr -i Version).Substring(9)
    Write-Output  "WinGet Version of $WinGetPackage.$Channel is $GetWinGetVersion"
    Write-Output ""

    Write-Output "Retrieving Latest version of $WinGetPackage.$Channel"
    $GetLatestVersion = ((Get-NevergreenApp -Name $NevergreenPackage | Where-Object {$_.Channel -eq $Channel}).Version)
    Write-Output "Latest Version of $WinGetPackage.$Channel is $GetLatestVersion"
    Write-Output ""

    Write-Output "Retrieving Latest version $GetLatestVersion URL"
    $GetLatestUri =  ((Get-NevergreenApp -Name $NevergreenPackage | Where-Object {$_.Channel -eq $Channel}).Uri)
    Write-Output $GetLatestUri
    Write-Output ""

    if ($GetWinGetVersion -lt $GetLatestVersion) {
        Write-Output "Update available"
        Write-Output "Creating Manifest for $WinGetPackage.$Channel version $GetLatestVersion"
        wingetcreate update --urls $GetLatestUri --version "$GetLatestVersion" "$WinGetPackage.$Channel"
    }
    else {
        Write-Output "You've latest version installed"
    }
    Write-Output ""
}
 
Stop-Transcript