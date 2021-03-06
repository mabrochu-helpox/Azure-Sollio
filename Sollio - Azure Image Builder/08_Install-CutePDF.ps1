########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################

Write-Host "08_Install-CutePDF.ps1"

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force -ErrorAction SilentlyContinue
$logpath = "C:\HelpOX\GoldenImage\Log"
$LogFile = "C:\HelpOX\GoldenImage\Log\$env:computername.txt"

if (!(Test-Path $LogFile)) {
    write-host 'Creation du fichier de log'
    New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force -ErrorAction SilentlyContinue

}

########################################################
## Install CutePDF Writer                             ##
########################################################


  
try{
    Add-Content -Path $LogFile "========================== Installation De CutePDF =========================="

    $now = Get-Date -Format "MM/dd/yyyy HH:mm"
    Add-Content -Path $LogFile "[$now] Telechargement de CutePDF en cours ..."
        
    Write-Host -ForegroundColor yellow "[HelpOX] Installing CutePDF Writer in progress..."
    New-Item -Path "c:\" -Name "temp" -ItemType "directory"
    Invoke-WebRequest -Uri 'https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/CuteWriter.exe' -OutFile 'C:\temp\CuteWriter.exe'
    $now = Get-Date -Format "MM/dd/yyyy HH:mm"
    Add-Content -Path $LogFile "[$now] Telechargement de CutePDF terminer"
    Add-Content -Path $LogFile "[$now] Installation de CutePDF en cours ..."
    C:\temp\CuteWriter.exe /VERYSILENT /NORESTART
    Start-sleep -Seconds 180
    $now = Get-Date -Format "MM/dd/yyyy HH:mm"
    Add-Content -Path $LogFile "[$now] Installation de CutePDF terminer"
    Remove-Item "C:\temp" -Force -Recurse -Confirm:$false
    Add-Content -Path $LogFile "[$now] Nettoyage des sources de CutePDF terminer"

}
catch {
        Write-Error $_
}  
