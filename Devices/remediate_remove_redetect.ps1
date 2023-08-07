# Removes device (pnputil.exe /remove-device) and re-detects (pnputil.exe /scan-devices) devices

$ClassFilterExclude = ""
$ClassFilterInclude = "*"
$DeviceIDFilterExclude = ""
$DeviceIDFilterInclude = "*"

[array]$DevicesWithIssue = Get-PnpDevice -PresentOnly -Status ERROR -ErrorAction SilentlyContinue | 
    Where-Object PNPClass -notin $ClassFilterExclude | 
    Where-Object {if ("*" -in $ClassFilterInclude) { $_} elseif ($_.PNPClass -in $ClassFilterInclude) {$_}} |
    Where-Object PNPDeviceID -notin $DeviceIDFilterExclude | 
    Where-Object {if ("*" -in $DeviceIDFilterInclude) { $_} elseif ($_.PNPDeviceID -in $DeviceIDFilterInclude) {$_}}

$Output = ""
if ($DevicesWithIssue.count -gt 0) {
    Foreach ($Device in $DevicesWithIssue) {
        $FriendlyName = [string]::IsNullOrWhiteSpace($Device.FriendlyName) ? "N/A" : $Device.FriendlyName
        $PNPClass = [string]::IsNullOrWhiteSpace($Device.PNPClass) ? "N/A" : $Device.PNPClass

        Write-Verbose "Removing PNPDeviceID: $($Device.PNPDeviceID) Device: $FriendlyName Class: $PNPClass"
        $PnpUtilOut += (pnputil.exe /remove-device "$($Device.PNPDeviceID)") | Out-String
        Write-Verbose "Redetect Devices"
        $PnpUtilOut += (pnputil.exe /scan-devices) | Out-String
        $Output += " | Redetect PNPDeviceID: $($Device.PNPDeviceID) Device: $FriendlyName Class: $PNPClass"
    }
    Write-Host $Output.TrimStart(" |")
}
else {
    Write-Host "No Devices with issues found"
}


