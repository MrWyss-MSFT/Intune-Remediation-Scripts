# Removes device (pnputil.exe /remove-device) and re-detects (pnputil.exe /scan-devices) devices
$ClassFilterExclude = "Net"
$ClassFilterInclude = "*"

[array]$DevicesWithIssue = Get-PnpDevice -PresentOnly -Status ERROR -ErrorAction SilentlyContinue | 
    Where-Object PNPClass -notin $ClassFilterExclude | 
    Where-Object {if ("*" -in $ClassFilterInclude) { $_} elseif ($_.PNPClass -in $ClassFilterInclude) {$_}} 

$Output = ""
if ($DevicesWithIssue.count -gt 0) {
    Foreach ($Device in $DevicesWithIssue) {
        Write-Verbose "Removing Device: $($Device.FriendlyName) Class: $($Device.PNPClass)"
        $PnpUtilOut += (pnputil.exe /remove-device "$($Device.PNPDeviceID)") | Out-String
        Write-Verbose "Redetect Devices"
        $PnpUtilOut += (pnputil.exe /scan-devices) | Out-String
        $Output += " | Redetect Device: $($Device.FriendlyName) Class: $($Device.PNPClass)"
    }
    Write-Host $Output.TrimStart(" |")
    #exit 1
}
else {
    Write-Host "No Devices with issues found"
    #exit 0
}


