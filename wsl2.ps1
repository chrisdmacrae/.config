# Automatically sets up wsl2 in the background
# And allows you to immediately go get a distro from the
# Windows store and use it in Windows Terminal

Write-Output "Welcome to .config for Windows Subsystem For Linux 2 (WSL2)"

$WIN_VERSION = (Get-WmiObject Win32_OperatingSystem).BuildNumber

if ($WIN_VERSION -le 1903) {
    Write-Host "You have an outdated version of Windows. Please update to 1903.18362 for x64 systems and 2004.19041 for ARM systems."
    Read-Host "Press any key to exit"
    exit 1 
}

$STATE_PATH = Join-Path -Path $env:temp -ChildPath .config -AdditionalChildPath wsl2.json
$STATE = {
    enabled: $true
}
if (!Test-Path -Path $STATE_PATH) {
    $STATE | ConvertTo-Json | Set-Content -Path $STATE_PATH
}
else {
    $STATE = Get-Content -Path $STATE_PATH -Raw | ConvertFrom-Json
}

if (!STATE.enabled) {
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    Restart-Computer
    exit 0
}

$WSL2_UPDATE_URI = 'https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi'
$WSL2_UPDATE_PATH = Join-Path -Path $env:temp -ChildPath .config -AdditionalChildPath wsl_update_x64.msi
Invoke-WebRequest -Uri $WSL2_UPDATE_URI -Outfile $WSL2_UPDATE_PATH
Start-Process -Wait msiexec /i $WSL2_UPDATE_PATH /quiet
wsl --set-default-version 2

Write-Host "Installed WSL. Head to https://aka.ms/wslstore to select a Linux distrubution to use!"
Read-Host "Press any key to exit"