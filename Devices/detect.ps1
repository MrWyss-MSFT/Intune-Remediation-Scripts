# Check if there are Devices that do not work properly, 
# see README.md for more information on the filters

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
        
        Write-Verbose "Device: $FriendlyName Class: $PNPClass PNPDeviceID: $($Device.PNPDeviceID) ConfigManagerErrorCode: $($Device.ConfigManagerErrorCode)"
        $Output += " | Device: $FriendlyName Class: $PNPClass PNPDeviceID: $($Device.PNPDeviceID) Err: $($Device.ConfigManagerErrorCode)"
    }
    Write-Host $Output.TrimStart(" |")
    exit 1
}
else {
    Write-Host "No Devices with issues found"
    exit 0
}
