<#
.Synopsis
   Script de changement divers Registre etc
.DESCRIPTION
   Le script met la touche final a l'image registre / services etc
.CREATOR
    Marc-Andre Brochu | ited | mabrochu@it-ed.com | 514-666-4357 Ext:3511
.DATE
    30 Septembre 2022
.VERSION
    1.0.1 Premier Commit du script
#>

########################################################
##              Variable and Logs / Others            ##
########################################################

write-host "99_Other_Config.ps1"

Set-TimeZone "US Eastern Standard Time"

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force
New-Item -Path "C:\HelpOX\GoldenImage\LanguagePack" -ItemType directory -force
$LogFile = "C:\HelpOX\GoldenImage\Log\$env:computername.txt"

if (!(Test-Path $LogFile)) {
    write-host 'Creation du fichier de log'
    New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force

}

########################################################
##               Disable Windows Services             ##
########################################################

Add-Content -Path $LogFile "========================== Other Scripts Finalising the Final toutch =========================="

$now = Get-Date -Format "MM/dd/yyyy HH:mm"
Add-Content -Path $LogFile "[$now] Désactivation du service de recherche windows et de synchronisation"

Stop-Service -name wsearch -force
Set-Service -name wsearch -startupType disabled

Stop-Service -name CscService -force
Set-Service -name CscService -startupType disabled

########################################################
##                Disable A and D Drives              ##
########################################################

$now = Get-Date -Format "MM/dd/yyyy HH:mm"
Add-Content -Path $LogFile "[$now] Désactivation du lecteur CD"
#Desactivatrion du lecteur CD
Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\cdrom -Name Start -Value 4 -Type Dword

$now = Get-Date -Format "MM/dd/yyyy HH:mm"
Add-Content -Path $LogFile "[$now] Désactivation du lecteur de disquette"
#Desactivatrion du lecteur Disquette
Get-PnpDevice -Class FloppyDisk | Disable-PnpDevice -Confirm:$false

########################################################
##                Disable A and D Drives              ##
########################################################