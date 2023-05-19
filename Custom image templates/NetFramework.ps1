########################################################
## Install NetFramework 3.5                           ##
########################################################

<#
.Synopsis
   Script d'installation de netFramework 
.DESCRIPTION
    Installation de NetFrameWork
.CREATOR
    Marc-André Brochu | ited | mabrochu@ited.com | 514-666-4357 Ext:3511
.DATE
    20 Fevrier 2022
.VERSION
    1.0.1 Premier Commit du script
#>

########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################
write-host "03_Install-NetFramework.ps1"
New-Item -Path "C:\ited\GoldenImage\Log" -ItemType directory -force
$logpath = "C:\ited\GoldenImage\Log"
$LogFile = "C:\ited\GoldenImage\Log\$env:computername.txt"
$path = "C:\Windows\Microsoft.NET\Framework64\v3.5"

if (!(Test-Path $LogFile)) {
    write-host 'Creation du fichier de log'
    New-Item -Path "C:\ited\GoldenImage\Log\$env:computername.txt" -ItemType file -force

}
if (!(Test-Path $path)) {
  
    try{
        Add-Content -Path $LogFile "========================== Installation De NetFrameWork 3.5 =========================="
        Write-Host -ForegroundColor yellow "[ited] Installing NetFramework 3.5 en cours ..."
        $now = Get-Date -Format "MM/dd/yyyy HH:mm"
        Add-Content -Path $LogFile "[$now] Installation De NetFrameWork 3.5 en cours ..."
        DISM /Online /Enable-Feature /FeatureName:NetFx3 /All
        $now = Get-Date -Format "MM/dd/yyyy HH:mm"
        Add-Content -Path $LogFile "[$now] Installation De NetFrameWork 3.5 completer"
        Write-Host -ForegroundColor yellow "[ited] Installing NetFramework 3.5 completer"
        write-host "ited - Installation de NetFramework 3.5 success"
        #ajout 16 mai 2023
        Restart-Computer -force
    }
    catch {
            Write-Error $_
    }  
}
else 
{
    Write-Host -ForegroundColor Green "[ited] NetFramework 3.5 is already installed on the server!"
}
