<#
.NAME
    IPv4 Search, to quickly find the IPv4 Address of a computer in a domain.
.SYNOPSIS
    To quickly find the IPv4 Address of a computer in a domain. Since the program is using Resolve-DnsName you track any ip address for any website
.INPUTS
    Only the computer name is needed, or the webstie name.

.DEVELOPER
    CC @ GitHub: https://github.com/CarlosCana

#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#$objIcon = New-Object system.drawing.icon ("C:\Windows\Installer\{FFD1F7F1-1AC9-4BC4-A908-0686D635ABAF}\installer.ico")
#$objForm.Icon = $objIcon

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '300,400'
$Form.text                       = "Ipv4 Findr"
$Form.BackColor                  = "#ffffff"
$Form.TopMost                    = $false
$form.StartPosition              = 'CenterScreen'
$Form.MaximizeBox                = $false
$Form.MinimizeBox                = $false
$Form.FormBorderStyle            = 'Fixed3D'

$Title                           = New-Object system.Windows.Forms.Label
$Title.text                      = "Ipv4  Findr"
$Title.AutoSize                  = $true
$Title.width                     = 86
$Title.height                    = 20
$Title.location                  = New-Object System.Drawing.Point(100,20)
$Title.Font                      = 'Lucida Sans Unicode,13,style=Bold'

$LabelHostname                   = New-Object system.Windows.Forms.Label
$LabelHostname.text              = "Hostname"
$LabelHostname.AutoSize          = $true
$LabelHostname.width             = 65
$LabelHostname.height            = 20
$LabelHostname.location          = New-Object System.Drawing.Point(113,70)
$LabelHostname.Font              = 'Lucida Sans,11'

$Description                     = New-Object system.Windows.Forms.Label
$Description.text                = "ex : google.com or cumputer name"
$Description.BackColor           = "#ffffff"
$Description.AutoSize            = $true
$Description.width               = 150
$Description.height              = 15
$Description.location            = New-Object System.Drawing.Point(75,100)
$Description.Font                = 'Microsoft Sans Serif,7,style=Italic'
$Description.ForeColor           = "#686868"

$SearchBox                       = New-Object system.Windows.Forms.TextBox
$SearchBox.multiline             = $false
$SearchBox.text                  = ""
$SearchBox.width                 = 175
$SearchBox.height                = 30
$SearchBox.location              = New-Object System.Drawing.Point(20,130)
$SearchBox.Font                  = 'Lucida Sans,10'

$SearchButton                    = New-Object system.Windows.Forms.Button
$SearchButton.BackColor          = "#12bee2"
$SearchButton.text               = "Search"
$SearchButton.width              = 80
$SearchButton.height             = 30
$SearchButton.location           = New-Object System.Drawing.Point(200,129)
$SearchButton.Font               = 'Lucida Sans,10,style=Bold'
$SearchButton.ForeColor          = "#ffffff"
$Form.AcceptButton               = $SearchButton

$ProgressBar                     = New-Object system.Windows.Forms.ProgressBar
$ProgressBar.width               = 260
$ProgressBar.height              = 20
$ProgressBar.value               = 0
$ProgressBar.location            = New-Object System.Drawing.Point(20,175)

$ResultTitle                     = New-Object system.Windows.Forms.Label
$ResultTitle.text                = "Ip Result"
$ResultTitle.AutoSize            = $true
$ResultTitle.width               = 72
$ResultTitle.height              = 20
$ResultTitle.location            = New-Object System.Drawing.Point(115,220)
$ResultTitle.Font                = 'Lucida Sans,11'
$ResultTitle.ForeColor           = "#000000"

$IpResult                        = New-Object system.Windows.Forms.Label
$IpResult.AutoSize               = $false
$IpResult.width                  = 180
$IpResult.height                 = 120
$IpResult.location               = New-Object System.Drawing.Point(80,250)
$IpResult.Font                   = 'Lucida Sans,10,style=Bold'

###Search Function


$SearchButton.Add_Click(

        {
        Resolve-DnsName -Name $SearchBox.text -ErrorAction SilentlyContinue -ErrorVariable ResolveError
            if(!$ResolveError)
            {
                $IpResult.text = "`n" + (Resolve-DnsName -Name $SearchBox.text -Type A).IPAddress + "`n";
                $IpResult.Font = 'Lucida Sans,12,style=Bold'
                $IpResult.ForeColor = "#000000"
                $ProgressBar.value = 100;
            }
            else
            {
                Write-Host "Impossible to find ¯\_(ツ)_/¯ "
                $IpResult.text = "`nImpossible to find`n      ¯\_(ツ)_/¯";
                $IpResult.Font = "Bold, 12"
                $IpResult.ForeColor = "#EB0B42"
                $ProgressBar.value = 100;
            }
        }


)






$Form.controls.AddRange(@($Title,$LabelHostname,$SearchButton,$SearchBox,$Groupbox,$ProgressBar,$Description, $ResultTitle, $IpResult))
#$Groupbox.controls.AddRange(@($ResultTitle,$IpResult))


[void]$Form.ShowDialog()
