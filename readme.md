# Codec WinGet

## Requirements

### WinGet

Install latest release of [WinGet](https://github.com/microsoft/winget-cli/)

```pwsh
Add-AppPackage -path https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
```

### WingetCreate

Install [WinGet-Create](https://github.com/microsoft/winget-create)

```pwsh
winget install wingetcreate
```

### Nevergreen

Install [Nevergreen](https://github.com/DanGough/Nevergreen) Powershell module

```pwsh
Install-Module -Name Nevergreen
```

>Note: Powershell should be in elevated mode.

## Run

```pwsh
./app.ps1
```
