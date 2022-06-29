$URL = "https://github.com/microsoft/winget-pkgs/tree/master/manifests/c/CodecGuide/K-LiteCodecPack/Basic"

$UrlLinks = ((Invoke-WebRequest $URL).Links | select -expand href | findstr -i Basic/)

Write-Host $UrlLinks

$Versions = 