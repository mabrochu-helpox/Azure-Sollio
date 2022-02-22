<#
.Synopsis
   Script d'installation de Office 365 Francais
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

Write-Host -ForegroundColor Green "[HelpOX] Beginning of Prod-WVD node configuration in progress..."
Set-ExecutionPolicy Unrestricted -Force

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force
New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force
$logpath = "C:\HelpOX\GoldenImage\Log"

########################################################
## Install NetFramework 3.5                           ##
########################################################

$path = "C:\Windows\Microsoft.NET\Framework64\v3.5"

if (!(Test-Path $path)) {
  
    try{
        Write-Host -ForegroundColor yellow "[HelpOX] Installing NetFramework 3.5 in progress..."
        DISM /Online /Enable-Feature /FeatureName:NetFx3 /All 
  }
    catch {
            Write-Error $_
    }  
}
else 
{
    Write-Host -ForegroundColor Green "[HelpOX] NetFramework 3.5 is already installed on the server!"
}
