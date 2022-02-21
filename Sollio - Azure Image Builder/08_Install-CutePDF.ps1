########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################

Write-Host -ForegroundColor Green "[HelpOX] Début de la configuration node Prod-WVD en cours ..."
Set-ExecutionPolicy Unrestricted -Force

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force
New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force
$logpath = "C:\HelpOX\GoldenImage\Log"


########################################################
## Install CutePDF Writer                             ##
########################################################

$path = "C:\Program Files (x86)\CutePDF Writer\CutePDFWriter.exe"

if (!(Test-Path $path)) {
  
    try{
        Write-Host -ForegroundColor yellow "[HelpOX] Installation de CutePDF Writer en cours ..."
        \\NETAPP-B377.ERPCOOP-SOLLIO.NET\Sollio\GoldenIMG\Softwares\CuteWriter.exe /VERYSILENT /NORESTART
  }
    catch {
            Write-Error $_
    }  
}
else 
{
    Write-Host -ForegroundColor Green "[HelpOX] CutePDF Writer est déja installé sur le serveur !"
}