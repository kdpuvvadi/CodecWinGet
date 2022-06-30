$URL = "https://api.github.com/repos/microsoft/winget-pkgs/contents/manifests/c/CodecGuide/K-LiteCodecPack/Basic?ref=master"

$APIResponse = ((Invoke-WebRequest  -uri $URL).Content | ConvertFrom-Json)


$versions= $APIResponse | ForEach-Object  {"$($_.name)"} | Format-Table

Write-Host $versions

# $RecentVersion = $APIResponse | Measure-Object -Maximum

# Write-Host $RecentVersion