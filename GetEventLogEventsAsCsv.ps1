Write-Host "Exporting the Application Event Log..."
Get-EventLog -LogName Application | Sort-Object -Property TimeGenerated -Descending |
Export-Csv -NoTypeInformation -Path ".\$($ENV:COMPUTERNAME)_Event-Log-Application.csv"
 
Write-Host "Exporting the System Event Log..."
Get-EventLog -LogName System | Sort-Object -Property TimeGenerated -Descending |
Export-Csv -NoTypeInformation -Path ".\$($ENV:COMPUTERNAME)_Event-Log-System.csv"
 
Write-Host "Exporting the Host Compute Service Admin Event Log..."
Get-WinEvent -LogName Microsoft-Windows-Hyper-V-Compute-Admin | Sort-Object -Property TimeCreated -Descending |
Export-Csv -NoTypeInformation -Path ".\$($ENV:COMPUTERNAME)_Event-Log-Host-Compute-Admin.csv"
 
Write-Host "Exporting the Host Compute Service Operational Event Log..."
Get-WinEvent -LogName Microsoft-Windows-Hyper-V-Compute-Operational | Sort-Object -Property TimeCreated -Descending |
Export-Csv -NoTypeInformation -Path ".\$($ENV:COMPUTERNAME)_Event-Log-Host-Compute-Operational.csv"
 
Write-Host "Exporting the Host Network Service Admin Event Log..."
Get-WinEvent -LogName Microsoft-Windows-Host-Network-Service-Admin | Sort-Object -Property TimeCreated -Descending |
Export-Csv -NoTypeInformation -Path ".\$($ENV:COMPUTERNAME)_Event-Log-Host-Network-Service-Admin.csv"
 
Write-Host "Exporting the Host Network Service Operational Event Log..."
Get-WinEvent -LogName Microsoft-Windows-Host-Network-Service-Operational | Sort-Object -Property TimeCreated -Descending |
Export-Csv -NoTypeInformation -Path ".\$($ENV:COMPUTERNAME)_Event-Log-Host-Network-Service-Operational.csv"

<#
# And for special debug circumstances you can collect the WinNat Operational log (not enabled by default)
$logName = 'Microsoft-Windows-WinNat/Oper'
$log = New-Object System.Diagnostics.Eventing.Reader.EventLogConfiguration $logName
$log.IsEnabled=$true
$log.SaveChanges()

# After WinNat enabled and whatever issue manifests...
Write-Host "Exporting the WinNat Operational Event Log..."
$logName = 'Microsoft-Windows-WinNat/Oper'
Get-WinEvent -LogName $logName | Sort-Object -Property TimeCreated -Descending |
Export-Csv -NoTypeInformation -Path ".\$($ENV:COMPUTERNAME)_Event-Log-$($logName.Replace('/', '-')).csv"
#>

Write-Host "Creating a zip file of the event log CSV files..."
Get-ChildItem ".\$($ENV:COMPUTERNAME)_Event-Log*.csv" | Compress-Archive -DestinationPath ".\$($ENV:COMPUTERNAME)_Event-Logs-$(Get-Date -Format FileDateTime).zip"
Write-Host "Creating a zip file of the event log CSV files complete."