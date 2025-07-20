#!/usr/bin/env pwsh
# now I know the shebang for powershell ^ :) 

param(
    [Parameter(Mandatory=$true)]
    [string]$scenario
)

function Show-Help {
    Write-Output"`nUsage: .\vmAutomation.ps1 -scenario [start|stop] can be 'start' or 'stop' for VMs"
    exit 1
}

# Azure runbooks' webhooks
startUrl="https://[redacted]webhook.ne.azure-automation.net/webhooks?token=pv"
stopUrl="https://[redacted]webhook.ne.azure-automation.net/webhooks?token=vm"

switch ($scenario) {
    "start" {
        Write-Output "Starting VMs..."
        Invoke-WebRequest -Method Post -Uri $startUrl
    }
    "stop" {
        Write-Output "Stopping VMs..."
        Invoke-WebRequest -Method Post -Uri $stopUrl
    }
    default {
        Show-Help
    }
}