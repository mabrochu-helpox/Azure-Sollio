########################################################
## Install CutePDF Writer                             ##
########################################################

<#
.Synopsis
   Installation de Foxit Reader
.DESCRIPTION
   Installation silencieuse de Foxit Reader
.NOTES
   Le scipt s'execute en mode silent et créer un log dans 
.EXAMPLE
    .\SyncACP.ps1 -ACP_Folder PPARV (Sync le dossier PPARV)
.AUTHOR
   Marc-André Brochu / HelpOX / 514-666-4357 Ext:3511 / mabrochu@helpox.com
.VERSION
   1.0.0 - 12 Avril 2022: 
    - Version inital du script fonctionalités de bases
#>

########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################

Set-ExecutionPolicy Unrestricted -Force

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force
New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force
$logpath = "C:\HelpOX\GoldenImage\Log"
$Log_File = "C:\HelpOX\GoldenImage\Log\$env:computername.txt"
$now = Get-Date -Format "MM/dd/yyyy HH:mm"


if (-not(Test-Path -Path $Log_File  -PathType Leaf)) {
    
    Write-Host "Le fichier de log est indisponible. Création du fichier de log"
    New-Item -path C:\HelpOX -ItemType Directory | Out-Null
    New-Item -path $Log_File -ItemType File | Out-Null

}



$path = "C:\Program Files (x86)\Foxit Software\Foxit PDF Reader\FoxitPDFReader.exe"

if (!(Test-Path $path)) {
  
    try{
        Add-Content -Path $Log_File "========================== Installation de Foxit Reader =========================="
        $now = Get-Date -Format "MM/dd/yyyy HH:mm"
        Add-Content -Path $Log_File "[$now] Installing Foxit Reader in progress..."
        New-Item -Path "c:\" -Name "temp" -ItemType "directory"
        Invoke-WebRequest -Uri 'https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/FoxitPDFReader1121_L10N_Setup.msi' -OutFile 'C:\temp\FoxitPDFReader1121_L10N_Setup.msi'
        C:\temp\FoxitPDFReader1121_L10N_Setup.msi /quiet
        Start-sleep -Seconds 90
        Remove-Item "C:\temp" -Force -Recurse -Confirm:$false

        $now = Get-Date -Format "MM/dd/yyyy HH:mm"
        Add-Content -Path $Log_File "[$now] Foxit reader installed successfully"
  }
    catch {
            Write-Error $_
    }  
}
else 
{
    Write-Host -ForegroundColor Green "[HelpOX] Foxit Reader is already installed on the server!"
}
