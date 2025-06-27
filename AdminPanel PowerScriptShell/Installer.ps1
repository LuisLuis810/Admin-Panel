# Relaunch as admin if not already
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Start-Process powershell "-File `"$PSCommandPath`"" -Verb RunAs
            exit
            }

            # Ask permission
            $answer = Read-Host "Do you want to allow this app to run in the background? (yes/no)"
            if ($answer -ne "yes") {
                Write-Host "Exiting..."
                    exit
                    }

                    # Launch GUI admin panel
                    $scriptPath = Join-Path $PSScriptRoot "admin_panel.ps1"
                    Start-Process powershell -ArgumentList "-WindowStyle Hidden -File `"$scriptPath`""
                    Write-Host "✅ Admin Panel is now running in the background."
                    