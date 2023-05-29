<#
.Synopsis
   Script d'installation de DataBaseEngine
.DESCRIPTION
    Installation de DataBaseEngine
.AUTHOR
    Marc-André Brochu / 514-666-4357 Ext:3511 / mabrochu@it-ed.com
.DATE
    20 Fevrier 2022
.VERSION
   1.0.0 Premier Commit du script
   1.0.1 - 19 Mai 2023: 
    - Changement pour dossier ited
#>

########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################
write-host "ited - Installation de DataBaseEngine"

New-Item -Path "C:\ited\GoldenImage\Log" -ItemType directory -force
$logpath = "C:\ited\GoldenImage\Log"
$LogFile = "C:\ited\GoldenImage\Log\$env:computername.txt"

if (!(Test-Path $LogFile)) {
    write-host 'Creation du fichier de log'
    New-Item -Path "C:\ited\GoldenImage\Log\$env:computername.txt" -ItemType file -force

}

########################################################
## Register AccessDatabaseEngine                      ##
########################################################

if (-not (Get-WmiObject win32_product | where{$_.Name -like "*Microsoft Access database engine 2010*"}))
{
    try{
         Add-Content -Path $LogFile "========================== Installation DATABASE ENGINE =========================="
         $now = Get-Date -Format "MM/dd/yyyy HH:mm"
         Add-Content -Path $LogFile "[$now] Telechargement Database Engine en cours ..."
         Write-Host -ForegroundColor yellow "[ited] Installation de Microsoft Access database engine 2010 ..."
         New-Item -Path "c:\" -Name "temp" -ItemType "directory" -force
         Invoke-WebRequest -Uri 'https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/AccessDatabaseEngine.exe' -OutFile 'C:\temp\AccessDatabaseEngine.exe'
         $now = Get-Date -Format "MM/dd/yyyy HH:mm"
         Add-Content -Path $LogFile "[$now] Telechargement Database Engine Completer"
         Add-Content -Path $LogFile "[$now] Installation de Database Engine en cours ..."
         C:\temp\AccessDatabaseEngine.exe /quiet
         sleep 90
         $now = Get-Date -Format "MM/dd/yyyy HH:mm"
         Add-Content -Path $LogFile "[$now] Installation de Database Engine Completer"
         #Remove-Item "C:\temp" -Force -Recurse -Confirm:$false
         write-host "ited - Installation de Database Engine success"
        }
        catch {
            Write-Error $_
        }
}
else 
{
    Write-Host -ForegroundColor Green "[ited] Microsoft Access database engine 2010 is already installed on the server!"
}
