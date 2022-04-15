########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################

Write-Host -ForegroundColor Green "[HelpOX] Beginning of Prod-WVD node configuration in progress..."
Set-ExecutionPolicy Unrestricted -Force

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force
$logpath = "C:\HelpOX\GoldenImage\Log"
$LogFile = "C:\HelpOX\GoldenImage\Log\$env:computername.txt"

if (!(Test-Path $LogFile)) {
    write-host 'Creation du fichier de log'
    New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force

}

########################################################
## Install Ghost Script                               ##
########################################################

$path = "C:\Program Files\gs\gs9.55.0\bin\gswin64.exe"

if (!(Test-Path $path)) {
  
    try{
        Add-Content -Path $LogFile "========================== Installation De GhostScript =========================="

        $now = Get-Date -Format "MM/dd/yyyy HH:mm"
        Add-Content -Path $LogFile "[$now] Telechargement de GhostScript en cours ..."
    
        Write-Host -ForegroundColor yellow "[HelpOX] Installing GhostScript..."
        New-Item -Path "c:\" -Name "temp" -ItemType "directory"
        Invoke-WebRequest -Uri 'https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/gs9550w64.exe' -OutFile 'C:\temp\gs9550w64.exe'
        $now = Get-Date -Format "MM/dd/yyyy HH:mm"
        Add-Content -Path $LogFile "[$now] Telechargement de GhostScript terminer"
        Add-Content -Path $LogFile "[$now] Installation de GhostScript en cours ..."
        C:\temp\gs9550w64.exe /S
        Start-sleep -Seconds 90
        $now = Get-Date -Format "MM/dd/yyyy HH:mm"
        Add-Content -Path $LogFile "[$now] Installation de GhostScript terminer"        
        Remove-Item "C:\temp" -Force -Recurse -Confirm:$false
        Add-Content -Path $LogFile "[$now] Nettoyage des sources de GhostScript terminer" 
        Add-Content -Path $LogFile "========================== Installation De GhostScript =========================="
  }
    catch {
            Write-Error $_
    }  
}
else 
{
    Write-Host -ForegroundColor Green "[HelpOX] GhostScript is already installed on the server!"
}
