$PackageName = "CodecGuide.K-LiteCodecPack"

$Channels = @(
    "Basic"
    "Standard"
    "Full"
    "Mega"
)
foreach ($Channel in $Channels) {
    $GetWinGetVersion = (winget show "$PackageName.$Channel" | findstr -i Version).Substring(9)
    Write-Output  "WinGet Version of $PackageName.$Channel is $GetWinGetVersion"

   
}
 
