########################################################
## Install Adobe Reader                               ##
########################################################

<#
.Synopsis
   Installation de Adobe Reader
.DESCRIPTION
   Installation silencieuse de Adobe Reader
.NOTES
   Le scipt s'execute en mode silent et créer un log dans 
.AUTHOR
   Marc-André Brochu / HelpOX / 514-666-4357 Ext:3511 / mabrochu@helpox.com
.VERSION
   1.0.0 - 12 Avril 2022: 
    - Version inital du script fonctionalités de bases
#>

########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################

write-host "09_Install-AdobeReader.ps1"

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force
$logpath = "C:\HelpOX\GoldenImage\Log"
$Log_File = "C:\HelpOX\GoldenImage\Log\$env:computername.txt"
$now = Get-Date -Format "MM/dd/yyyy HH:mm"


if (-not(Test-Path -Path $Log_File  -PathType Leaf)) {
    
    Write-Host "Le fichier de log est indisponible. Création du fichier de log"
    New-Item -path C:\HelpOX -ItemType Directory | Out-Null
    New-Item -path $Log_File -ItemType File | Out-Null

}

 
try{
    Add-Content -Path $Log_File "========================== Installation de Adobe Reader =========================="
    $now = Get-Date -Format "MM/dd/yyyy HH:mm"
    Add-Content -Path $Log_File "[$now] Installing Foxit Reader in progress..."
    New-Item -Path "c:\" -Name "temp" -ItemType "directory"
    Invoke-WebRequest -Uri 'https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/AcroRdrDC2200120117_fr_FR.exe' -OutFile 'C:\temp\AcroRdrDC2200120117_fr_FR.exe'
    C:\temp\AcroRdrDC2200120117_fr_FR.exe /sAll /rs /msi EULA_ACCEPT=YES
    Start-sleep -Seconds 90
    Remove-Item "C:\temp" -Force -Recurse -Confirm:$false

    $now = Get-Date -Format "MM/dd/yyyy HH:mm"
    Add-Content -Path $Log_File "[$now] Adobe Reader installed successfully"
}
catch {
        Write-Error $_
}  
