<#
.Synopsis
   Script d'installation de Fidelio
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
write-host "06_Install-Fidelio.ps1"

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force
$logpath = "C:\HelpOX\GoldenImage\Log"
$LogFile = "C:\HelpOX\GoldenImage\Log\$env:computername.txt"

if (!(Test-Path $LogFile)) {
    write-host 'Creation du fichier de log'
    New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force

}

########################################################
## Install de Commsoft Fidelio                        ##
########################################################

if (-not (Get-WmiObject win32_product | where{$_.Name -like "*Fidelio*"}))
{
    try {
         Add-Content -Path $LogFile "========================== Installation de Commsoft Fidelio =========================="

         $now = Get-Date -Format "MM/dd/yyyy HH:mm"
         Add-Content -Path $LogFile "[$now] Telechargement de Fidelio en cours ..."
         
         Write-Host -ForegroundColor yellow "[HelpOX] Installing Commsoft Fidelio..."
         New-Item -Path "c:\" -Name "temp" -ItemType "directory"
         Invoke-WebRequest -Uri 'https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/FidelioSetup.msi' -OutFile 'C:\temp\FidelioSetup.msi'
         
         $now = Get-Date -Format "MM/dd/yyyy HH:mm"
         Add-Content -Path $LogFile "[$now] Telechargement de Fidelio terminer" 
         Add-Content -Path $LogFile "[$now] Installation de Fidelio en cour ..." 
         
         msiexec /quiet /passive /qn /i "C:\temp\FidelioSetup.msi"
         Start-sleep -Seconds 90

         $now = Get-Date -Format "MM/dd/yyyy HH:mm"
         Add-Content -Path $LogFile "[$now] Installation de Fidelio terminer" 

         Remove-Item "C:\Program Files (x86)\Commsoft Technologies Inc" -Force -Recurse -Confirm:$false
         Remove-Item C:\Users\Public\Desktop\* -Force -Confirm:$false
         Remove-Item "C:\temp" -Force -Recurse -Confirm:$false
         
         $now = Get-Date -Format "MM/dd/yyyy HH:mm"
         Add-Content -Path $LogFile "[$now] Nettoyage des sources de Fidelio terminer" 
    }

    catch {
           Write-Error $_
    }

}
else 
{
    Write-Host -ForegroundColor Green "[HelpOX] Commsoft Fidelio is already installed on the server!"
}
