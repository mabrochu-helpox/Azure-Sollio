########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################

Write-Host -ForegroundColor Green "[HelpOX] D�but de la configuration node Prod-WVD en cours ..."
Set-ExecutionPolicy Unrestricted -Force

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force
New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force
$logpath = "C:\HelpOX\GoldenImage\Log"

########################################################
## Install de Commsoft Fidelio                        ##
########################################################

if (-not (Get-WmiObject win32_product | where{$_.Name -like "*Fidelio*"}))
{
    try {
        Write-Host -ForegroundColor yellow "[HelpOX] Installation de Commsoft Fidelio ..."
        msiexec /quiet /passive /qn /i "\\NETAPP-B377.ERPCOOP-SOLLIO.NET\Sollio\GoldenIMG\Softwares\FidelioSetup.msi"
        Start-sleep -Seconds 60
        Remove-Item "C:\Program Files (x86)\Commsoft Technologies Inc" -Force -Recurse -Confirm:$false
        Remove-Item C:\Users\Public\Desktop\* -Force -Confirm:$false
    }

    catch {
           Write-Error $_
    }

}
else 
{
    Write-Host -ForegroundColor Green "[HelpOX] Commsoft Fidelio est d�ja install� sur le serveur !"
}