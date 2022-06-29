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
    Write-Host -NoNewline "Retrieving WinGet version of $WinGetPackage.$Channel "
    $GetWinGetVersion = (WinGet show "$WinGetPackage.$Channel" | findstr -i Version).Substring(9)
    Write-Host "Done" -ForegroundColor Green

    Write-Host -NoNewline "Retrieving Latest version of $WinGetPackage.$Channel "
    $GetLatestVersion = ((Get-NevergreenApp -Name $NevergreenPackage | Where-Object {$_.Channel -eq $Channel}).Version)
    Write-Host "Done" -ForegroundColor Green

    if ($GetWinGetVersion -lt $GetLatestVersion) {
        Write-Host -NoNewline "Retrieving Latest version $GetLatestVersion URL "
        $GetLatestUri =  ((Get-NevergreenApp -Name $NevergreenPackage | Where-Object {$_.Channel -eq $Channel}).Uri)
        Write-Host "Done" -ForegroundColor Green
        Write-Host "Update available"
        Write-Host "Creating Manifest for $WinGetPackage.$Channel version $GetLatestVersion"
        wingetcreate update --urls $GetLatestUri --version "$GetLatestVersion" "$WinGetPackage.$Channel"
    }
    else {
        Write-Host ""
        Write-Host "WinGet Version of $WinGetPackage.$Channel is Latest" -ForegroundColor Green
    }
    Write-Output ""
    Start-Sleep 3
}
 
Stop-Transcript