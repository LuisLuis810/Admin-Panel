Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# === Main Form ===
$form = New-Object System.Windows.Forms.Form
$form.Text = "Admin Panel"
$form.Size = New-Object System.Drawing.Size(300, 200)
$form.StartPosition = "CenterScreen"
$form.TopMost = $true

# Relaunch the script with admin rights if not already elevated
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
        
            Start-Process powershell "-File `"$PSCommandPath`"" -Verb RunAs
                exit
                }

Start-Process AdminPanel.ps1
# === Button: View System Info ===
$btnSysInfo = New-Object System.Windows.Forms.Button
$btnSysInfo.Text = "🔍 View System Info"
$btnSysInfo.Size = New-Object System.Drawing.Size(250, 30)
$btnSysInfo.Location = New-Object System.Drawing.Point(20, 20)
$btnSysInfo.Add_Click({
    $info = Get-ComputerInfo | Out-String
        [Bem.Windows.Forms.MessageBox]::Show($info, "System Info")
        })
        $form.Controls.Add($btnSysInfo)

        # === Button: List Users ===
        $btnUsers = New-Object System.Windows.Forms.Button
        $btnUsers.Text = "👤 List Users"
        $btnUsers.Size = New-Object System.Drawing.Size(250, 30)
        $btnUsers.Location = New-Object System.Drawing.Point(20, 60)
        $btnUsers.Add_Click({
            $users = Get-LocalUser | Select-Object Name, Enabled | Out-String
                [System.Windows.Forms.MessageBox]::Show($users, "Users")
                })
                $form.Controls.Add($btnUsers)

                # === Button: Exit ===
                $btnExit = New-Object System.Windows.Forms.Button
                $btnExit.Text = "❌ Exit"
                $btnExit.Size = New-Object System.Drawing.Size(250, 30)
                $btnExit.Location = New-Object System.Drawing.Point(20, 100)
                $btnExit.Add_Click({ $form.Close() })
                $form.Controls.Add($btnExit)

                # === Show Form ===
                $form.ShowDialog()
