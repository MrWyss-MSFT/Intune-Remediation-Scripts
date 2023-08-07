# Intune-Remediation-Scripts

A collection of hopefully useful Intune remediation scripts

## Current Collection

- **Registry**
  - [Registry/detect.ps1](Registry/detect.ps1): validates registry values (Path, Name, Type, Value)
  - [Registry/remediate.ps1](Registry/remediate.ps1): sets registry values (Path, Name, Type, Value)
  - [Registry/README.md](Registry/README.md): instructions

- **Devices**
  - [Devices/detect.ps1](Devices/detect.ps1): checks devices, if they are working as expected, if not it will return the devices and exit non-zero.
  - [Devices/remediate_remove_redetect.ps1](Devices/remediate_remove_redetect.ps1): will remove the devices and trigger a re-detect.
  - [Devices/README.md](Devices/README.md): instructions (filtering, etc.)

## Changelog

### [0.0.2] - 2021-08-07

- added PNPDeviceID include and exclude filter in [Devices/detect.ps1](Devices/detect.ps1) and [Devices/remediate_remove_redetect.ps1](Devices/remediate_remove_redetect.ps1) and updated [Registry/README.md](Registry/README.md)
- fixed empty string for DeviceClass and DeviceName in [Devices/detect.ps1](Devices/detect.ps1) and [Devices/remediate_remove_redetect.ps1](Devices/remediate_remove_redetect.ps1)

### [0.0.1] - 2021-07-27

- added [Devices/](Devices/)

### [initial] - 2023-07-26

- added [Registry/](Registry/)

## Contributions

- please do
