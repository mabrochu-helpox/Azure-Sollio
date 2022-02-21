########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################

Write-Host -ForegroundColor Green "[HelpOX] D�but de la configuration node Prod-WVD en cours ..."
Set-ExecutionPolicy Unrestricted -Force

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force
New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force
$logpath = "C:\HelpOX\GoldenImage\Log"

########################################################
## Install NetFramework 3.5                           ##
########################################################

$path = "C:\Windows\Microsoft.NET\Framework64\v3.5"

if (!(Test-Path $path)) {
  
    try{
        Write-Host -ForegroundColor yellow "[HelpOX] Installation de NetFramework 3.5 en cours ..."
        DISM /Online /Enable-Feature /FeatureName:NetFx3 /All 
  }
    catch {
            Write-Error $_
    }  
}
else 
{
    Write-Host -ForegroundColor Green "[HelpOX] NetFramework 3.5 est d�ja install� sur le serveur !"
}
