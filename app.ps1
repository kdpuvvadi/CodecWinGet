param(
    $log,
    $pat
)
# Import Scripts 
. ./lib/transcript.ps1

# Stop on error
$ErrorActionPreference = 'Stop'

$WinGetPackage = "CodecGuide.K-LiteCodecPack"
$NevergreenPackage = "KLiteCodecPack"

if ($log){
    Start-Log
}

$Channels = @(
    "Basic"
    "Standard"
    "Full"
    "Mega"
)
foreach ($Channel in $Channels) {
    
    Write-Host -NoNewline "Retrieving WinGet version of $WinGetPackage.$Channel "
    $WingetURL = "https://api.github.com/repos/microsoft/winget-pkgs/contents/manifests/c/CodecGuide/K-LiteCodecPack/$($Channel)?ref=master"
    $APIResponse = ((Invoke-WebRequest  -uri $WingetURL).Content | ConvertFrom-Json)
    $versions= (($APIResponse | Format-Table -Property Name | out-string).Trim())
    $GetWinGetVersion = $versions.Substring($versions.Length-6)
    Write-Host -NoNewline "Done " -ForegroundColor Green
    Write-Host $GetWinGetVersion -ForegroundColor Red

    $GetpackageNevergreen = Get-NevergreenApp -Name $NevergreenPackage | Where-Object {$_.Channel -eq $Channel}

    Write-Host -NoNewline "Retrieving Latest version of $WinGetPackage.$Channel "
    $GetLatestVersion = $GetpackageNevergreen.Version
    Write-Host -NoNewline "Done " -ForegroundColor Green
    Write-Host $GetLatestVersion -ForegroundColor Red

    if ($GetWinGetVersion -lt $GetLatestVersion) {
        Write-Host -NoNewline "Retrieving Latest version $GetLatestVersion URL "
        $GetLatestUri = $GetpackageNevergreen.Uri
        Write-Host "Done" -ForegroundColor Green
        Write-Host "Update available"
        Write-Host "Creating Manifest for $WinGetPackage.$Channel version $GetLatestVersion"
        .\wingetcreate update "$WinGetPackage.$Channel" -u $GetLatestUri -v "$GetLatestVersion" -s -t $pat
    }
    else {
        Write-Host ""
        Write-Host "WinGet Version of $WinGetPackage.$Channel is Latest" -ForegroundColor Green
    }
    Write-Output ""
}

if ($log){
    Stop-Transcript
}
