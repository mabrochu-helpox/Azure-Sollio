########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################

Write-Host -ForegroundColor Green "[HelpOX] Beginning of Prod-WVD node configuration in progress..."
Set-ExecutionPolicy Unrestricted -Force

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force
New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force
$logpath = "C:\HelpOX\GoldenImage\Log"

########################################################
## Install Ghost Script                               ##
########################################################

$path = "C:\Program Files\gs\gs9.55.0\bin\gswin64.exe"

if (!(Test-Path $path)) {
  
    try{
        Write-Host -ForegroundColor yellow "[HelpOX] Installing GhostScript..."
        New-Item -Path "c:\" -Name "temp" -ItemType "directory"
        Invoke-WebRequest -Uri 'https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/gs9550w64.exe' -OutFile 'C:\temp\gs9550w64.exe'
        C:\temp\gs9550w64.exe /S
        Start-sleep -Seconds 60
        Remove-Item "C:\temp" -Force -Recurse -Confirm:$false
  }
    catch {
            Write-Error $_
    }  
}
else 
{
    Write-Host -ForegroundColor Green "[HelpOX] GhostScript is already installed on the server!"
}