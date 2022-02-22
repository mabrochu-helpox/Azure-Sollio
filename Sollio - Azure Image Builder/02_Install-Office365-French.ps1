<#
.Synopsis
   Script d'installation de Office 365 Francais
.DESCRIPTION
   Le script télécharger un fichier XML et setup.exe et installe Office
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
New-Item -Path "C:\HelpOX\GoldenImage\Office365" -ItemType Directory -force
$logpath = "C:\HelpOX\GoldenImage\Log"


########################################################
## Téléchargement du fichier Setup.exe et Config      ##
########################################################

#$SetupPath = "C:\HelpOX\GoldenImage\Office365\setup.exe"
#$ConfigPath = "C:\HelpOX\GoldenImage\Office365\Configuration.xml"


Invoke-WebRequest -Uri "https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/setup.exe" -OutFile "C:\HelpOX\GoldenImage\Office365\setup.exe"
Invoke-WebRequest -Uri "https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/Configuration.xml" -OutFile "C:\HelpOX\GoldenImage\Office365\Configuration.xml"

########################################################
## Téléchargement des sources Office 365              ##
########################################################

C:\HelpOX\GoldenImage\Office365\setup.exe /download C:\HelpOX\GoldenImage\Office365\Configuration.xml

########################################################
## Install Office 365 with config file                ##
########################################################

if (-not (Get-WmiObject win32_product | where{$_.Name -like "Office 16 Click-to-Run Extensibility Component"}))
{
    try {
        Write-Host -ForegroundColor yellow "[HelpOX] Installation de Office 365 en Cours ..."
        C:\HelpOX\GoldenImage\Office365\setup.exe /configure C:\HelpOX\GoldenImage\Office365\Configuration.xml
    }

    catch {
           Write-Error $_
    }

}
else 
{
    Write-Host -ForegroundColor Green "[HelpOX] Office 365 is already installed on the server!"
}