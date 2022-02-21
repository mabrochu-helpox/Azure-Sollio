########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################

Write-Host -ForegroundColor Green "[HelpOX] D�but de la configuration node Prod-WVD en cours ..."
Set-ExecutionPolicy Unrestricted -Force

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force
New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force
$logpath = "C:\HelpOX\GoldenImage\Log"

########################################################
## Install MMC for Active Directory User Accec        ##
########################################################

$path = "C:\Windows\System32\dsa.msc"

if (!(Test-Path $path)) {
  
    try{
        Write-Host -ForegroundColor yellow "[HelpOX] Installation de la console MMC Active Directory en Cours ..."
        New-Item -Path "c:\" -Name "temp" -ItemType "directory"
        Copy-Item -Path "\\NETAPP-B377.ERPCOOP-SOLLIO.NET\Sollio\GoldenIMG\Softwares\WindowsTH-RSAT_WS_1803-x64.msu" -Destination "C:\temp"
        C:\temp\WindowsTH-RSAT_WS_1803-x64.msu /quiet /passive /norestart
        sleep 60
        Remove-Item "C:\temp" -Force -Recurse -Confirm:$false
  }
    catch {
            Write-Error $_
    }  
}
else 
{
    Write-Host -ForegroundColor Green "[HelpOX] La console MMC Active Directory est d�ja install� sur le serveur !"
}


#Reboot Required