########################################################
## Install CutePDF Writer                             ##
########################################################

<#
.Synopsis
   Installation de CutePDF Writer    
.DESCRIPTION
   Installation silencieuse de CutePDF Writer    
.NOTES
   Le scipt s'execute en mode silent et créer un log dans 
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

write-host "ited - Installation de CutePDF Writer "
New-Item -Path "C:\ited\GoldenImage\Log" -ItemType directory -force -ErrorAction SilentlyContinue
$logpath = "C:\ited\GoldenImage\Log"
$LogFile = "C:\ited\GoldenImage\Log\$env:computername.txt"

if (!(Test-Path $LogFile)) {
    write-host 'Creation du fichier de log'
    New-Item -Path "C:\ited\GoldenImage\Log\$env:computername.txt" -ItemType file -force -ErrorAction SilentlyContinue

}


try{
    Add-Content -Path $LogFile "========================== Installation De CutePDF =========================="
    $now = Get-Date -Format "MM/dd/yyyy HH:mm"
    Add-Content -Path $LogFile "[$now] Telechargement de CutePDF en cours ..."
    Write-Host -ForegroundColor yellow "[ited] Installing CutePDF Writer in progress..."
    New-Item -Path "c:\" -Name "temp" -ItemType "directory" -force
    Invoke-WebRequest -Uri 'https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/CuteWriter.exe' -OutFile 'C:\temp\CuteWriter.exe'
    $now = Get-Date -Format "MM/dd/yyyy HH:mm"
    Add-Content -Path $LogFile "[$now] Telechargement de CutePDF terminer"
    Add-Content -Path $LogFile "[$now] Installation de CutePDF en cours ..."
    C:\temp\CuteWriter.exe /VERYSILENT /NORESTART
    Start-sleep -Seconds 180
    $now = Get-Date -Format "MM/dd/yyyy HH:mm"
    Add-Content -Path $LogFile "[$now] Installation de CutePDF terminer"
    #Remove-Item "C:\temp" -Force -Recurse -Confirm:$false
    Add-Content -Path $LogFile "[$now] Nettoyage des sources de CutePDF terminer"
    write-host "ited - Installation de CutePDF success"

}
catch {
        Write-Error $_
}  
