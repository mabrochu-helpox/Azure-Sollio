########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################

Write-Host -ForegroundColor Green "[HelpOX] Beginning of Prod-WVD node configuration in progress..."
Set-ExecutionPolicy Unrestricted -Force

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force
New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force
$logpath = "C:\HelpOX\GoldenImage\Log"


########################################################
## Install CutePDF Writer                             ##
########################################################

$path = "C:\Program Files (x86)\Foxit Software\Foxit PDF Reader\FoxitPDFReader.exe"

if (!(Test-Path $path)) {
  
    try{
        Write-Host -ForegroundColor yellow "[HelpOX] Installing Foxit Reader in progress..."
        New-Item -Path "c:\" -Name "temp" -ItemType "directory"
        Invoke-WebRequest -Uri 'https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/FoxitPDFReader1121_L10N_Setup.msi' -OutFile 'C:\temp\FoxitPDFReader1121_L10N_Setup.msi'
        C:\temp\FoxitPDFReader1121_L10N_Setup.msi /quiet
        Start-sleep -Seconds 60
        Remove-Item "C:\temp" -Force -Recurse -Confirm:$false

  }
    catch {
            Write-Error $_
    }  
}
else 
{
    Write-Host -ForegroundColor Green "[HelpOX] Foxit Reader Writer is already installed on the server!"
}
