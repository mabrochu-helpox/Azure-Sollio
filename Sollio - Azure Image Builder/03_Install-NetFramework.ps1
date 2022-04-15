<#
.Synopsis
   Script d'installation de netFramework 
.DESCRIPTION
    Installation de NetFrameWork
.CREATOR
    Marc-André Brochu | HelpOX | mabrochu@helpox.com | 514-666-4357 Ext:3511
.DATE
    20 Fevrier 2022
.VERSION
    1.0.1 Premier Commit du script
#>

########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################
write-host "03_Install-NetFramework.ps1"

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force
$logpath = "C:\HelpOX\GoldenImage\Log"
$LogFile = "C:\HelpOX\GoldenImage\Log\$env:computername.txt"

if (!(Test-Path $LogFile)) {
    write-host 'Creation du fichier de log'
    New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force

}

########################################################
## Install NetFramework 3.5                           ##
########################################################

Add-Content -Path $LogFile "========================== Installation De NetFrameWork 3.5 =========================="

$path = "C:\Windows\Microsoft.NET\Framework64\v3.5"

if (!(Test-Path $path)) {
  
    try{
         Write-Host -ForegroundColor yellow "[HelpOX] Installing NetFramework 3.5 en cours ..."
         $now = Get-Date -Format "MM/dd/yyyy HH:mm"
         Add-Content -Path $LogFile "[$now] Installation De NetFrameWork 3.5 en cours ..."
        
         DISM /Online /Enable-Feature /FeatureName:NetFx3 /All
        
         $now = Get-Date -Format "MM/dd/yyyy HH:mm"
         Add-Content -Path $LogFile "[$now] Installation De NetFrameWork 3.5 completer"
         Write-Host -ForegroundColor yellow "[HelpOX] Installing NetFramework 3.5 completer"
         Add-Content -Path $LogFile "========================== Installation De NetFrameWork 3.5 =========================="

  }
    catch {
            Write-Error $_
    }  
}
else 
{
    Write-Host -ForegroundColor Green "[HelpOX] NetFramework 3.5 is already installed on the server!"
}
