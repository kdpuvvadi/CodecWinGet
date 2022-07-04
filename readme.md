# Codec WinGet

## Requirements

### WingetCreate

Install [WinGetCreate](https://github.com/microsoft/winget-create) with `WinGet` package manager

```pwsh
WinGet install wingetcreate
```
Download the binary directly

```pwsh
Invoke-WebRequest https://aka.ms/wingetcreate/latest -OutFile ./wingetcreate.exe
```


### Nevergreen

Install [Nevergreen](https://github.com/DanGough/Nevergreen) Powershell module

```pwsh
Install-Module -Name Nevergreen
```

### Package Details with Nevergreen

Get Latest details of package

```pwsh
Get-NevergreenApp -Name KLiteCodecPack
```

To get details of specific channel such as `Basic` in `K-Lite Codec Pack`

```pwsh
Get-NevergreenApp -Name KLiteCodecPack | Where-Object {$_.Channel -eq "Basic"}
```

>Note: Powershell should be in elevated mode.

## Run

```pwsh
./app.ps1
```
