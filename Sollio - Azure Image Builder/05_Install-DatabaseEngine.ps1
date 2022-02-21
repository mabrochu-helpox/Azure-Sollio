########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################

Write-Host -ForegroundColor Green "[HelpOX] D�but de la configuration node Prod-WVD en cours ..."
Set-ExecutionPolicy Unrestricted -Force

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force
New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force
$logpath = "C:\HelpOX\GoldenImage\Log"

########################################################
## Register AccessDatabaseEngine                      ##
########################################################

if (-not (Get-WmiObject win32_product | where{$_.Name -like "*Microsoft Access database engine 2010*"}))
{
    try {
        Write-Host -ForegroundColor yellow "[HelpOX] Installation de Microsoft Access database engine 2010 ..."
        \\NETAPP-B377.ERPCOOP-SOLLIO.NET\Sollio\GoldenIMG\Softwares\AccessDatabaseEngine.exe /quiet
    }

    catch {
           Write-Error $_
    }

}
else 
{
    Write-Host -ForegroundColor Green "[HelpOX] Microsoft Access database engine 2010 est d�ja install� sur le serveur !"
}