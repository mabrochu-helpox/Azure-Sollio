########################################################
## Install Ghost Script                               ##
########################################################

<#
.Synopsis
   Script d'installation de GhostScript
.DESCRIPTION
    Installation de GhostScript
.CREATOR
    Marc-André Brochu |ited | mabrochu@it-ed.com | 514-666-4357 Ext:3511
.DATE
    20 Fevrier 2022
.VERSION
    1.0.1 Premier Commit du script
#>

########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################

write-host "ited - Installation de GhostScript"
New-Item -Path "C:\ited\GoldenImage\Log" -ItemType directory -force
$logpath = "C:\ited\GoldenImage\Log"
$LogFile = "C:\ited\GoldenImage\Log\$env:computername.txt"
$path = "C:\Program Files\gs\gs9.55.0\bin\gswin64.exe"

if (!(Test-Path $LogFile)) {
    write-host 'Creation du fichier de log'
    New-Item -Path "C:\ited\GoldenImage\Log\$env:computername.txt" -ItemType file -force
}
if (!(Test-Path $path)) {
  
    try{
        Add-Content -Path $LogFile "========================== Installation De GhostScript =========================="
        $now = Get-Date -Format "MM/dd/yyyy HH:mm"
        Add-Content -Path $LogFile "[$now] Telechargement de GhostScript en cours ..."
        Write-Host -ForegroundColor yellow "[ited] Installing GhostScript..."
        New-Item -Path "c:\" -Name "temp" -ItemType "directory" -force
        Invoke-WebRequest -Uri 'https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/gs910w64.exe' -OutFile 'C:\temp\gs910w64.exe'
        $now = Get-Date -Format "MM/dd/yyyy HH:mm"
        Add-Content -Path $LogFile "[$now] Telechargement de GhostScript terminer"
        Add-Content -Path $LogFile "[$now] Installation de GhostScript en cours ..."
        C:\temp\gs910w64.exe /S
        Start-sleep -Seconds 90
        $now = Get-Date -Format "MM/dd/yyyy HH:mm"
        Add-Content -Path $LogFile "[$now] Installation de GhostScript terminer"        
        #Remove-Item "C:\temp" -Force -Recurse -Confirm:$false
        Add-Content -Path $LogFile "[$now] Nettoyage des sources de GhostScript terminer" 
        write-host "ited - Installation de GhostScript success"
    }
    catch {
            Write-Error $_
    }  
}
else 
{
    Write-Host -ForegroundColor Green "[ited] GhostScript is already installed on the server!"
}
