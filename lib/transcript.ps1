function Start-Log{
# Logs
    $logDir = "$PWD\logs"
    $logMessage = "The log dir doesn't exist. This dir will be used for storing logs."
    If (Test-Path $logDir) {
        Write-Output "$logDir exists. Skipping."
    }
    Else {
        Write-Output $logMessage
        Start-Sleep 1
        New-Item -Path "$logDir" -ItemType Directory
        Write-Output "The log Dir was successfully created." `n
        Start-Sleep 1
    }
    $logfile = Get-Date -Format "ddMMyy_hhmm"
    $logfilepath =  "$logDir\log_$logfile.log"
    Start-Transcript -path $logfilepath -IncludeInvocationHeader -Append
    Write-Output ""
}
