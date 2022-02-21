########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################

Write-Host -ForegroundColor Green "[HelpOX] D�but de la configuration node Prod-WVD en cours ..."
Set-ExecutionPolicy Unrestricted -Force

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force
New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force
$logpath = "C:\HelpOX\GoldenImage\Log"

########################################################
## Install Office 365 with config file                ##
########################################################

if (-not (Get-WmiObject win32_product | where{$_.Name -like "Office 16 Click-to-Run Extensibility Component"}))
{
    try {
        Write-Host -ForegroundColor yellow "[HelpOX] Installation de Office 365 en Cours ..."
        \\NETAPP-B377.ERPCOOP-SOLLIO.NET\Sollio\GoldenIMG\Office365\setup.exe /configure \\NETAPP-B377.ERPCOOP-SOLLIO.NET\Sollio\GoldenIMG\Office365\Configuration.xml
    }

    catch {
           Write-Error $_
    }

}
else 
{
    Write-Host -ForegroundColor Green "[HelpOX] Office 365 est d�ja install� sur le serveur !"
}