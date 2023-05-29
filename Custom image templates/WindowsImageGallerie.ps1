########################################################
##         Set Windows Image Viewer as default        ##
########################################################

<#
.Synopsis
   Register Image Gallerie as default
.DESCRIPTION
   Le script enregistre image viewer par default
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
write-host "[ited] - Windows Image Gallerie Default en cours ..."
New-Item -Path "C:\ited\GoldenImage\Log" -ItemType directory -force
New-Item -Path "C:\ited\GoldenImage\LanguagePack" -ItemType directory -force
$LogFile = "C:\ited\GoldenImage\Log\$env:computername.txt"

if (!(Test-Path $LogFile)) {
    write-host 'Creation du fichier de log'
    New-Item -Path "C:\ited\GoldenImage\Log\$env:computername.txt" -ItemType file -force

}

########################################################
##         Set Windows Image Viewer as default        ##
########################################################

Add-Content -Path $LogFile "========================== Set Windows Image Viewer as Default =========================="
$now = Get-Date -Format "MM/dd/yyyy HH:mm"
Add-Content -Path $LogFile "[$now] Set Windows Image Viewer as Default"
$now = Get-Date -Format "MM/dd/yyyy HH:mm"
Add-Content -Path $LogFile "[$now] Enregistrement du DLL PhotoViewer.dll"
regsvr32 "C:\Program Files (x86)\Windows Photo Viewer\PhotoViewer.dll" /s
$now = Get-Date -Format "MM/dd/yyyy HH:mm"
Add-Content -Path $LogFile "[$now] Téléchargement des Reg file depuis Azure"
New-Item -Path "c:\" -Name "temp" -ItemType "directory"
Invoke-WebRequest -Uri 'https://github.com/mabrochu-ited/Azure-Sollio/raw/main/MSPhotoViewerReg/MSPhotoViewerReg.zip' -OutFile 'C:\temp\MSPhotoViewerReg.zip'
Expand-Archive C:\temp\MSPhotoViewerReg.zip -DestinationPath C:\temp -Force
$now = Get-Date -Format "MM/dd/yyyy HH:mm"
Add-Content -Path $LogFile "[$now] Importation des clefs de registres"
Invoke-Command {reg import "C:\temp\MS PhotoViewer.bmp.reg" *>&1 | Out-Null}
Invoke-Command {reg import "C:\temp\MS PhotoViewer.jpe.reg" *>&1 | Out-Null}
Invoke-Command {reg import "C:\temp\MS PhotoViewer.jpeg.reg" *>&1 | Out-Null}
Invoke-Command {reg import "C:\temp\MS PhotoViewer.jpg.reg" *>&1 | Out-Null}
write-host "[ited] - Images Gallerie Set success"
