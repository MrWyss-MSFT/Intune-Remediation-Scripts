# Devices

**detect.ps1** checks devices, if they are working as expected, if not it will return the devices and exit non-zero.
**remediate_remove_redetect.ps1** will remove the devices and trigger a re-detect.

## Usage/Examples

### Filter

- You can use the wildcard character `*` to match any device in the ```$ClassFilterInclude``` variable.
- Exclude has precedence over include.

```powershell
# Remove Display, Ports and Net class devices except for Net and USB class devices
$ClassFilterExclude = "Net", "USB"
$ClassFilterInclude = "Display", "Ports", "Net"
```

```powershell
# Remove any except for Net and USB class devices
$ClassFilterExclude = "Net", "USB"
$ClassFilterInclude = "*"
```
