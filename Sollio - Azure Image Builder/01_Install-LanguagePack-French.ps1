<#
.Synopsis
   Script de changement de langue Francais pour template AVD AIB
.DESCRIPTION
   Le script t�l�charger un zip avec les pack de langue Francais d'un blob storage Azure.
.CREATOR
    Marc-Andr� Brochu | HelpOX | mabrochu@helpox.com | 514-666-4357 Ext:3511
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
New-Item -Path "C:\HelpOX\GoldenImage\LanguagePack" -ItemType directory -force
New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force
$logpath = "C:\HelpOX\GoldenImage\Log"


########################################################
## Download and Unzip French Language Pack From BLOB  ##
########################################################

$Url = 'https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/WVD-FR-CA.zip' 
$ZipFile = 'C:\HelpOX\GoldenImage\LanguagePack\' + $(Split-Path -Path $Url -Leaf) 
$Destination= 'C:\HelpOX\GoldenImage\LanguagePack\' 
 
Invoke-WebRequest -Uri $Url -OutFile $ZipFile 
 
$ExtractShell = New-Object -ComObject Shell.Application 
$Files = $ExtractShell.Namespace($ZipFile).Items() 
$ExtractShell.NameSpace($Destination).CopyHere($Files) 
Start-Process $Destination

Remove-Item -Path 'C:\HelpOX\GoldenImage\LanguagePack\WVD-FR-CA.zip' -Force


########################################################
## Add Languages to running Windows Image for Capture##
########################################################

$CurentLanguage = get-WinUserLanguageList | foreach {$_.LanguageTag}

if ($CurentLanguage -ne "fr-CA" )
{
    try {
        
        Write-Host -ForegroundColor yellow "[HelpOX] Installation of the French language pack in progress..."

        ##Disable Language Pack Cleanup##
        Disable-ScheduledTask -TaskPath "\Microsoft\Windows\AppxDeploymentClient\" -TaskName "Pre-staged app cleanup"

        ##Set Language Pack Content Stores##
        [string]$LIPContent = "C:\HelpOX\GoldenImage\LanguagePack"


        ##French##
        Add-AppProvisionedPackage -Online -PackagePath $LIPContent\fr-ca\LanguageExperiencePack.fr-CA.Neutral.appx -LicensePath $LIPContent\fr-ca\License.xml
        Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-Client-Language-Pack_x64_fr-ca.cab
        Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-Basic-fr-ca-Package~31bf3856ad364e35~amd64~~.cab
        Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-Handwriting-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
        Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-OCR-fr-ca-Package~31bf3856ad364e35~amd64~~.cab
        Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-Speech-fr-ca-Package~31bf3856ad364e35~amd64~~.cab
        Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-TextToSpeech-fr-ca-Package~31bf3856ad364e35~amd64~~.cab
        Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~fr-ca~.cab
        Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~fr-ca~.cab
        Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~amd64~fr-ca~.cab
        Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~amd64~fr-ca~.cab
        Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~amd64~fr-ca~.cab
        Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-Printing-WFS-FoD-Package~31bf3856ad364e35~amd64~fr-ca~.cab
        Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~amd64~fr-ca~.cab
        Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~amd64~fr-ca~.cab
        $LanguageList = Get-WinUserLanguageList
        $LanguageList.Add("fr-ca")
        Set-WinUserLanguageList $LanguageList -force

        Set-WinSystemLocale fr-CA
        Set-WinUserLanguageList -LanguageList fr-CA -Force
        Set-WinUILanguageOverride -Language fr-CA 
        Set-Culture -CultureInfo fr-CA
        Set-WinHomeLocation -GeoId 39
        Set-TimeZone "US Eastern Standard Time"

    }

    catch {
           Write-Error $_
    }
    
}
else 
{
    Write-Host -ForegroundColor Green "[HelpOX] Le pack de langue francais est déja installé sur le serveur !"
}