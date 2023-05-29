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
New-Item -Path "C:\ited\GoldenImage\Log" -ItemType directory -force
New-Item -Path "C:\ited\GoldenImage\LanguagePack" -ItemType directory -force
$LogFile = "C:\ited\GoldenImage\Log\$env:computername.txt"

if (!(Test-Path $LogFile)) {
    write-host 'Creation du fichier de log'
    New-Item -Path "C:\ited\GoldenImage\Log\$env:computername.txt" -ItemType file -force

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

#net localgroup "FSLogix Profile Include List" "everyone" /delete
#net localgroup "FSLogix ODFC Include List" "everyone" /delete
