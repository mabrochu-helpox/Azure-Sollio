########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################

Write-Host -ForegroundColor Green "[HelpOX] D�but de la configuration node Prod-WVD en cours ..."
Set-ExecutionPolicy Unrestricted -Force

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force
New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force
$logpath = "C:\HelpOX\GoldenImage\Log"

########################################################
## Install Ghost Script                               ##
########################################################

$path = "C:\Program Files\gs\gs9.55.0\bin\gswin64.exe"

if (!(Test-Path $path)) {
  
    try{
        Write-Host -ForegroundColor yellow "[HelpOX] Installation de GhostScript en cours ..."
        \\NETAPP-B377.ERPCOOP-SOLLIO.NET\Sollio\GoldenIMG\Softwares\gs9550w64.exe /S
  }
    catch {
            Write-Error $_
    }  
}
else 
{
    Write-Host -ForegroundColor Green "[HelpOX] GhostScript est d�ja install� sur le serveur !"
}