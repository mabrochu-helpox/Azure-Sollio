########################################################
## Install MMC for Active Directory User Accec        ##
########################################################

<#
.Synopsis
   Script d'installation de Remote Administration Tool MMC
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
write-host "04_Install-MMC-Snap-In.ps1"
New-Item -Path "C:\ited\GoldenImage\Log" -ItemType directory -force
$logpath = "C:\ited\GoldenImage\Log"
$LogFile = "C:\ited\GoldenImage\Log\$env:computername.txt"
$path = "C:\Windows\System32\dsa.msc"

if (!(Test-Path $LogFile)) {
    write-host 'Creation du fichier de log'
    New-Item -Path "C:\ited\GoldenImage\Log\$env:computername.txt" -ItemType file -force

}
if (!(Test-Path $path)) {
  
    try{
         Add-Content -Path $LogFile "========================== Installation des Modules Active Directory =========================="
         Write-Host -ForegroundColor yellow "[ited] Installing the Active Directory MMC console in progress..."
         New-Item -Path "c:\" -Name "temp" -ItemType "directory" -force
         Invoke-WebRequest -Uri 'https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/WindowsTH-RSAT_WS_1803-x64.msu' -OutFile 'C:\temp\WindowsTH-RSAT_WS_1803-x64.msu'
         $now = Get-Date -Format "MM/dd/yyyy HH:mm"
         Add-Content -Path $LogFile "[$now] Telechargement module MMC AD completer"
         Add-Content -Path $LogFile "[$now] Installation module MMC AD en cours ..."
         
         C:\temp\WindowsTH-RSAT_WS_1803-x64.msu /quiet /passive /norestart
         sleep 90
         $now = Get-Date -Format "MM/dd/yyyy HH:mm"
         Add-Content -Path $LogFile "[$now] Instalation module MMC AD completer"        
         #Remove-Item "C:\temp" -Force -Recurse -Confirm:$false
         write-host "ited - Installation de MMC ADDIN success"
        }
        catch {
            Write-Error $_
        }  
}
else 
{
    Write-Host -ForegroundColor Green "[ited] The Active Directory MMC console is already installed on the server!"
}


#Reboot Required
