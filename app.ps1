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
 
