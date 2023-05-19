########################################################
## Install Adobe Reader                               ##
########################################################

<#
.Synopsis
   Installation de Adobe Reader
.DESCRIPTION
   Installation silencieuse de Adobe Reader
.NOTES
   Le scipt s'execute en mode silent
.AUTHOR
   Marc-André Brochu / 514-666-4357 Ext:3511 / mabrochu@it-ed.com
.VERSION
   1.0.0 - 12 Avril 2022: 
    - Version inital du script fonctionalités de bases
   1.0.1 - 19 Mai 2023: 
    - Changement pour dossier ited
#>

########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################

Write-Host "*** Starting AVD AIB CUSTOMIZER PHASE: Adobe Reader ***"
New-Item -Path "C:\ited\GoldenImage\Log" -ItemType directory -force -ErrorAction SilentlyContinue
$logpath = "C:\ited\GoldenImage\Log"
$Log_File = "C:\ited\GoldenImage\Log\$env:computername.txt"
$now = Get-Date -Format "MM/dd/yyyy HH:mm"

if (-not(Test-Path -Path $Log_File -PathType Leaf)) {
    Write-Host "[ited] - Le fichier de log est indisponible. Création du fichier de log"
    New-Item -path C:\ited -ItemType Directory | Out-Null -ErrorAction SilentlyContinue
    New-Item -path $Log_File -ItemType File | Out-Null -ErrorAction SilentlyContinue
}
try{
    Add-Content -Path $Log_File "========================== Installation de Adobe Reader =========================="
    $now = Get-Date -Format "MM/dd/yyyy HH:mm"
    Add-Content -Path $Log_File "[$now] Installing Adobe Reader in progress..."
    write-host "[ited] - Installation de Adobe Reader en cours ..."
    New-Item -Path "c:\" -Name "temp" -ItemType "directory"
    Invoke-WebRequest -Uri 'https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/AcroRdrDC2200120117_fr_FR.exe' -OutFile 'C:\temp\AcroRdrDC2200120117_fr_FR.exe'
    C:\temp\AcroRdrDC2200120117_fr_FR.exe /sAll /rs /msi EULA_ACCEPT=YES
    Start-sleep -Seconds 90
    #Remove-Item "C:\temp" -Force -Recurse -Confirm:$false
    $now = Get-Date -Format "MM/dd/yyyy HH:mm"
    Add-Content -Path $Log_File "[$now] Adobe Reader installed successfully"
    write-host "[ited] - Installation de Adobe Reader success"
}
catch {
        Write-Error $_
}  
