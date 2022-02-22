<#
.Synopsis
   Script d'installation de Remote Administration Tool MMC
.DESCRIPTION
    Installation de NetFrameWork
.CREATOR
    Marc-André Brochu | HelpOX | mabrochu@helpox.com | 514-666-4357 Ext:3511
.DATE
    20 Fevrier 2022
.VERSION
    1.0.1 Premier Commit du script
#>

########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################

Write-Host -ForegroundColor Green "[HelpOX] Beginning of Prod-WVD node configuration in progress..."
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force
New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force
$logpath = "C:\HelpOX\GoldenImage\Log"

########################################################
## Install MMC for Active Directory User Accec        ##
########################################################

$path = "C:\Windows\System32\dsa.msc"

if (!(Test-Path $path)) {
  
    try{
        Write-Host -ForegroundColor yellow "[HelpOX] Installing the Active Directory MMC console in progress..."
        New-Item -Path "c:\" -Name "temp" -ItemType "directory"
        Invoke-WebRequest -Uri 'https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/WindowsTH-RSAT_WS_1803-x64.msu' -OutFile 'C:\temp\WindowsTH-RSAT_WS_1803-x64.msu'
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
    Write-Host -ForegroundColor Green "[HelpOX] The Active Directory MMC console is already installed on the server!"
}


#Reboot Required