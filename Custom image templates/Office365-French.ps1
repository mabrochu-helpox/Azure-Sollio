########################################################
## Install Office 365 with config file                ##
########################################################

<#
.Synopsis
   Script d'installation de Office 365 Francais
.DESCRIPTION
   Le script télécharger un fichier XML et setup.exe et installe Office
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
write-host "02_Install-Office365-French.ps1"

New-Item -Path "C:\ited\GoldenImage\Log" -ItemType directory -force
New-Item -Path "C:\ited\GoldenImage\Office365" -ItemType Directory -force
$LogFile = "C:\ited\GoldenImage\Log\$env:computername.txt"
$logpath = "C:\ited\GoldenImage\Log"

if (!(Test-Path $LogFile)) {
    write-host 'Creation du fichier de log'
    New-Item -Path "C:\ited\GoldenImage\Log\$env:computername.txt" -ItemType file -force

}

########################################################
## Téléchargement du fichier Setup.exe et Config      ##
########################################################
Add-Content -Path $LogFile "========================== Installation de Office 365 Francais =========================="

Invoke-WebRequest -Uri "https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/setup.exe" -OutFile "C:\ited\GoldenImage\Office365\setup.exe"
Invoke-WebRequest -Uri "https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/Configuration.xml" -OutFile "C:\ited\GoldenImage\Office365\Configuration.xml"

$now = Get-Date -Format "MM/dd/yyyy HH:mm"
Add-Content -Path $LogFile "[$now] Telechargement du fichier setup.exe office 365 completer"
Add-Content -Path $LogFile "[$now] Telechargement du fichier Configuration.xml office 365 completer"

########################################################
## Téléchargement des sources Office 365              ##
########################################################

C:\ited\GoldenImage\Office365\setup.exe /download C:\ited\GoldenImage\Office365\Configuration.xml

$now = Get-Date -Format "MM/dd/yyyy HH:mm"
Add-Content -Path $LogFile "[$now] Telechargement des sources d'installation Office 365 completer"

########################################################
## Install Office 365 with config file                ##
########################################################

if (-not (Get-WmiObject win32_product | where{$_.Name -like "Office 16 Click-to-Run Extensibility Component"}))
{
    try {
         Write-Host -ForegroundColor yellow "[ited] Installation de Office 365 en Cours ..."
         C:\ited\GoldenImage\Office365\setup.exe /configure C:\ited\GoldenImage\Office365\Configuration.xml
         Get-Process -Name "setup" -ErrorAction SilentlyContinue | Wait-Process
         $now = Get-Date -Format "MM/dd/yyyy HH:mm"
         Add-Content -Path $LogFile "[$now] Installation de Office 365 completer"
         write-host "ited - Installation de Office 365 success"
    }

    catch {
           Write-Error $_
    }

}
else 
{
    Write-Host -ForegroundColor Green "[ited] Office 365 is already installed on the server!"
}

