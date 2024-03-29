########################################################
## Install Visual C++ 2015-2019                       ##
########################################################

<#
.Synopsis
   Installation de Visual C++ 2015-2019
.DESCRIPTION
   Installation silencieuse de Visual C++ 2015-2019
.NOTES
   Le scipt s'execute en mode silent et créer un log dans 
.AUTHOR
   Marc-André Brochu / ited / 514-666-4357 Ext:3511 / mabrochu@ited.com
.VERSION
   1.0.0 - 12 Avril 2022: 
    - Version inital du script fonctionalités de bases
#>

########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################
write-host "[ited] - Install Visual C++ en cours ..."
New-Item -Path "C:\ited\GoldenImage\Log" -ItemType directory -force -ErrorAction SilentlyContinue
$logpath = "C:\ited\GoldenImage\Log"
$Log_File = "C:\ited\GoldenImage\Log\$env:computername.txt"
$now = Get-Date -Format "MM/dd/yyyy HH:mm"

if (-not(Test-Path -Path $Log_File  -PathType Leaf)) {
    Write-Host "Le fichier de log est indisponible. Création du fichier de log"
    New-Item -path C:\ited -ItemType Directory -force | Out-Null
    New-Item -path $Log_File -ItemType File -force | Out-Null
}
try{
    Add-Content -Path $Log_File "========================== Installation de Visual C++ 2015-2019 =========================="
    $now = Get-Date -Format "MM/dd/yyyy HH:mm"
    Add-Content -Path $Log_File "[$now] Installing de Visual C++ 2015-2019 en cours ..."
    New-Item -Path "c:\" -Name "temp" -ItemType "directory" -force -ErrorAction SilentlyContinue
    Invoke-WebRequest -Uri 'https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/VC_redist.x64.exe' -OutFile 'C:\temp\VC_redist.x64.exe'
    Invoke-WebRequest -Uri 'https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/VC_redist.x86.exe' -OutFile 'C:\temp\VC_redist.x86.exe'
    C:\temp\VC_redist.x64.exe /Q /norestart
    Start-sleep -Seconds 90
    C:\temp\VC_redist.x86.exe /Q /norestart
    Start-sleep -Seconds 90
    #Remove-Item "C:\temp" -Force -Recurse -Confirm:$false
    $now = Get-Date -Format "MM/dd/yyyy HH:mm"
    Add-Content -Path $Log_File "[$now] Visual C++ 2015-2019 installed successfully"
    write-host "[ited] - Installation de Visual C++ success"
}
catch {
        Write-Error $_
}  
