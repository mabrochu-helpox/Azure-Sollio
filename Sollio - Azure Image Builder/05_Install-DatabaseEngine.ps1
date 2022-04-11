<#
.Synopsis
   Script d'installation de DataBaseEngine
.DESCRIPTION
    Installation de DataBaseEngine
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
        New-Item -Path "c:\" -Name "temp" -ItemType "directory"
        Invoke-WebRequest -Uri 'https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/AccessDatabaseEngine.exe' -OutFile 'C:\temp\AccessDatabaseEngine.exe'
        C:\temp\AccessDatabaseEngine.exe /quiet
        sleep 60
        Remove-Item "C:\temp" -Force -Recurse -Confirm:$false
    }

    catch {
           Write-Error $_
    }

}
else 
{
    Write-Host -ForegroundColor Green "[HelpOX] Microsoft Access database engine 2010 is already installed on the server!"
}
