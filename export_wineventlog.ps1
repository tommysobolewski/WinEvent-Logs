# Logs to extract from server
$logArray = @("System","Security","Application", "Setup")

# Grabs the server name to append to the log file extraction
$servername = $env:computername

# Provide the path with ending "\" to store the log file extraction.
$destinationpath = "C:\WindowsEventLogs\"

# Checks the last character of the destination path.  If it does not end in '\' it adds one.
# '.+?\\$' +? means any character \\ is looking for the backslash $ is the end of the line charater
if ($destinationpath -notmatch '.+?\\$')
{
    $destinationpath += '\'
}

# If the destination path does not exist it will create it
if (!(Test-Path -Path $destinationpath))
{
    New-Item -ItemType directory -Path $destinationpath
}

# Get the current date in YearMonthDay format
$logdate = Get-Date -format yyyyMMddHHmm

# Start Process Timer
$StopWatch = [system.diagnostics.stopwatch]::startNew()

# Start Code
Clear-Host

Foreach($log in $logArray)
{
    # If using Clear and backup
    $destination = $destinationpath + $servername + "-" + $log + "-" + $logdate + ".evtx"

    Write-Host "Extracting the $log file now."

    # Extract each log file listed in $logArray from the local server.
    wevtutil epl $log $destination

    # Write-Host "Clearing the $log file now."

    # Clear the log and backup to file.
    # WevtUtil cl $log

}

# End Code

# Stop Timer
$StopWatch.Stop()
$TotalTime = $StopWatch.Elapsed.TotalSeconds
$TotalTime = [math]::Round($totalTime, 2)
write-host "The Script took $TotalTime seconds to execute."
