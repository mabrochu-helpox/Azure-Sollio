<#
.Synopsis
   Script de changement de langue Francais pour template AVD AIB
.DESCRIPTION
   Le script download un zip avec les pack de langue Francais d'un blob storage Azure
.CREATOR
    Marc-Andre Brochu | HelpOX | mabrochu@helpox.com | 514-666-4357 Ext:3511
.DATE
    20 Fevrier 2022
.VERSION
    1.0.1 Premier Commit du script
    1.0.2 Ajout de log file
#>

########################################################
## Configuration de l'image AVD ERPCOOP-SOLLIO.NET    ##
########################################################
Set-TimeZone "US Eastern Standard Time"
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine

New-Item -Path "C:\HelpOX\GoldenImage\Log" -ItemType directory -force
New-Item -Path "C:\HelpOX\GoldenImage\LanguagePack" -ItemType directory -force
$LogFile = "C:\HelpOX\GoldenImage\Log\$env:computername.txt"

if (!(Test-Path $LogFile)) {
    write-host 'Creation du fichier de log'
    New-Item -Path "C:\HelpOX\GoldenImage\Log\$env:computername.txt" -ItemType file -force

}


########################################################
## Download and Unzip French Language Pack From BLOB  ##
########################################################

Add-Content -Path $LogFile "========================== Installation du Pack De Langue FR-CA 21H2 =========================="

$now = Get-Date -Format "MM/dd/yyyy HH:mm"
Add-Content -Path $LogFile "[$now] Telechargement du pack de langue en cours ..."
$Url = "https://sollioazureimagebuilder.blob.core.windows.net/sollioazureimagebuilder/21H2-fr-ca.zip"
$ZipFile = "21H2-fr-ca.zip"
$Destination = 'C:\HelpOX\GoldenImage\LanguagePack\' 
 
Invoke-WebRequest -Uri $Url -OutFile $Destination\$ZipFile
write-host 'Telechargement du pack de langue FR-CA terminer'

$now = Get-Date -Format "MM/dd/yyyy HH:mm"
Add-Content -Path $LogFile "[$now] Telechargement du pack de langue complete"

Add-Content -Path $LogFile "[$now] Extraction du pack de langue en cours ..."

Expand-Archive -LiteralPath "$Destination\$ZipFile" -DestinationPath $Destination
write-host 'Extraction du pack de langue FR-CA terminer'

$now = Get-Date -Format "MM/dd/yyyy HH:mm"
Add-Content -Path $LogFile "[$now] Extraction du pack de langue complete"

Remove-Item -Path "$Destination\$ZipFile" -Force
write-host 'Supression Archive pack de langue FR-CA terminer'

########################################################
## Add Languages to running Windows Image for Capture##
########################################################

$now = Get-Date -Format "MM/dd/yyyy HH:mm"
Add-Content -Path $LogFile "[$now] Installation des cab files en cours ..."
write-host 'Installation du pack de langue FR-CA en cours ...'

$CurentLanguage = get-WinUserLanguageList | foreach {$_.LanguageTag}

if ($CurentLanguage -ne "fr-CA" )
{
    try {
        ##Disable Language Pack Cleanup##
        Disable-ScheduledTask -TaskPath "\Microsoft\Windows\AppxDeploymentClient\" -TaskName "Pre-staged app cleanup"

        ##Set Language Pack Content Stores##
        [string]$LIPContent = "C:\HelpOX\GoldenImage\LanguagePack\21H2-fr-ca"

        ##French##
        Add-AppProvisionedPackage -Online -PackagePath $LIPContent\fr-ca\LanguageExperiencePack.fr-CA.Neutral.appx -LicensePath $LIPContent\fr-ca\License.xml
        Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-Client-Language-Pack_x64_fr-ca.cab
        Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-Basic-fr-ca-Package~31bf3856ad364e35~amd64~~.cab
        #Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-Handwriting-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
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


        ##Set Inbox App Package Content Stores##
        [string] $AppsContent = "C:\HelpOX\GoldenImage\LanguagePack\21H2-fr-ca\"

        ##Update installed Inbox Store Apps##
        foreach ($App in (Get-AppxProvisionedPackage -Online)) {
	        $AppPath = $AppsContent + $App.DisplayName + '_' + $App.PublisherId
	        Write-Host "Handling $AppPath"
	        $licFile = Get-Item $AppPath*.xml
	        if ($licFile.Count) {
		        $lic = $true
		        $licFilePath = $licFile.FullName
	        } else {
		        $lic = $false
	        }
	        $appxFile = Get-Item $AppPath*.appx*
	        if ($appxFile.Count) {
		        $appxFilePath = $appxFile.FullName
		        if ($lic) {
			        Add-AppxProvisionedPackage -Online -PackagePath $appxFilePath -LicensePath $licFilePath 
		        } else {
			        Add-AppxProvisionedPackage -Online -PackagePath $appxFilePath -skiplicense
		        }
	        }
        }

    }

    catch {
           Write-Error $_
    }
    
}
else 
{
    Write-Host -ForegroundColor Green "[HelpOX] Le pack de langue francais est déja installé sur le serveur !"
}

write-host 'Installation du pack de langue FR-CA terminer'
$now = Get-Date -Format "MM/dd/yyyy HH:mm"
Add-Content -Path $LogFile "[$now] Installation des cab files Complete"

try {

    $now = Get-Date -Format "MM/dd/yyyy HH:mm"
    Add-Content -Path $LogFile "[$now] Configuration du language FR CA par Default en cours ..."

    $LanguageList = Get-WinUserLanguageList
    $LanguageList.Add("fr-ca")
    Set-WinUserLanguageList $LanguageList -force

    Set-WinSystemLocale fr-CA
    Set-WinUserLanguageList -LanguageList fr-CA -Force
    Set-WinUILanguageOverride -Language fr-CA 
    Set-Culture -CultureInfo fr-CA
    Set-WinHomeLocation -GeoId 39
    Set-TimeZone "US Eastern Standard Time"
    
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\MUI\Settings" /v "PreferredUILanguages" /t REG_MULTI_SZ /d "fr-CA" /f

    $now = Get-Date -Format "MM/dd/yyyy HH:mm"
    Add-Content -Path $LogFile "[$now] Configuration du language FR CA par Default Complete"
    write-host 'Le pack de langue FR-CA est maintenant la langue par default'
    Add-Content -Path $LogFile "========================== Installation du Pack De Langue FR-CA 21H2 =========================="
}

catch {
        Write-Error $_
}
