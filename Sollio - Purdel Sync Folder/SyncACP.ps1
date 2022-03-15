<#
.Synopsis
   Script de synchonisation de fichier ACP
.DESCRIPTION
   Envoie d'un email avec attachtment pour execution d'un flow PowerAutomate
.NOTES
   Le scipt s'execute avec une tache planifié sur le serveur sceduleur01
.EXAMPLE
    .\SyncACP.ps1 -ACP_Folder PPARV (Sync le dossier PPARV)
.AUTHOR
   Marc-André Brochu / HelpOX / 514-666-4357 Ext:3511 / mabrochu@helpox.com
.VERSION
   1.0.0 - 12 Mars 2022: 
    - Version inital du script fonctionalités de bases
   1.1.0 - 14 Mars 2022: 
    - Ajout de parameter dans le script $ACP_Folder
    - Ajout d'une fonction de login dans fichier texte
#>


param(
     [Parameter()]
     [string]$ACP_Folder
 )

#ACP Configuration
$ACP_Path = "\\NETAPP-B377.ERPCOOP-SOLLIO.NET\Sollio\Commsoft\Rapports\Coop\PURDEL\ACP\$ACP_Folder"
$ACP_Log_File = "\\NETAPP-B377.ERPCOOP-SOLLIO.NET\Sollio\Commsoft\Rapports\Coop\PURDEL\ACP\$ACP_Folder\Proceded\_LOG_$ACP_Folder.txt"

#Email Configuration
$User = ""
$EmailTo = "nicecube@hotmail.com"
$EmailFrom = "purdelrepports@erpcoop-sollio.net"
$SMTPServer = “erpcoopsollio-net01i.mail.protection.outlook.com"


###### Script Dont Edit above this line ######

#Login config
$date = Get-Date -Format "dd/MM/yyyy HH:mm"

if (-not(Test-Path -Path $ACP_Log_File  -PathType Leaf)) {
    
    Write-Host "Le fichier de log est indisponible. Création du fichier de log"
    New-Item -path $ACP_Log_File -ItemType File | Out-Null
    Add-Content -Path $ACP_Log_File "========================== Log de synchronisation fichiers ACP $ACP_Folder =========================="

}
else{
    
    Write-Host "Le fichier de log est disponible"

}

$NewFiles = Get-ChildItem -Path $ACP_Path -Exclude Proceded | foreach {$_.Name}

foreach ($File in $NewFiles) {

    try {

        Move-Item -Path "$ACP_Path\$File" -Destination "$ACP_Path\Proceded\$File" -Force -ErrorAction SilentlyContinue
        Add-Content -Path $ACP_Log_File "$date : Déplacement du fichier $File dans le dossier Proceded"

    }
    catch {

        Write-Host "Error Move item $File"
        Add-Content -Path $ACP_Log_File "$date : Erreur de copie de fichier $File dans le dossier Proceded"

    }

    try {

        $Subject = $ACP_Folder
        $Body = "$File"
        $filenameAndPath = $ACP_Path + '\Proceded\' + $File
        $attachment = New-Object System.Net.Mail.Attachment($filenameAndPath)
        $SMTPClient = New-Object Net.Mail.SmtpClient($SMTPServer, 25)
        $SMTPClient.EnableSsl = $true
        $SMTPMessage = New-Object System.Net.Mail.MailMessage($EmailFrom,$EmailTo,$Subject,$Body)
        $SMTPMessage.Attachments.Add($attachment)
        $SMTPClient.Send($SMTPMessage)

        Write-Host "Envoie du email $File en cours ... 5"
        sleep 1
        Write-Host "Envoie du email $File en cours ... 4"
        sleep 1
        Write-Host "Envoie du email $File en cours ... 3"
        sleep 1
        Write-Host "Envoie du email $File en cours ... 2"
        sleep 1
        Write-Host "Envoie du email $File en cours ... 1"
        sleep 1

        Write-Host -ForegroundColor Green "Le Email contenant le fichié $File a été envoyé avec succes ! "
        Add-Content -Path $ACP_Log_File "$date : Email contenant le fichier $File a bien été envoyé au email $EmailTo"
    }

    catch {

        Add-Content -Path $ACP_Log_File "$date : L'envoie du email contenant le fichier $File a échoué ..."

    }


}
exit






