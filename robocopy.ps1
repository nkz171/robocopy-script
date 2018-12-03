Get-PSDrive 
[System.IO.DriveInfo]::getdrives()
#Get-Disk | Where-Object –FilterScript {$_.Bustype -Eq "USB"}
# Get-Wmiobject Win32_logicaldisk | Select-Object deviceid,size,freespace
$Laufwerksbuchstabe = Read-Host "Bitte geben Sie den entsprechenden Laufwerksbuchstaben ein!"

if (Test-Path "${Laufwerksbuchstabe}:\Sicherung_D\Pruefdatei---Nicht-loeschen.txt") 
{
ROBOCOPY "directorytosave" "${Laufwerksbuchstabe}:\save" /mir
ROBOCOPY "directorytosave" "${Laufwerksbuchstabe}:\save" /mir
Write-Host Die Datensicherung auf Laufwerk ${Laufwerksbuchstabe}: war erfolgreich!
pause
} 
else 
{
Write-Host USB Laufwerk ${Laufwerksbuchstabe}: ist nicht angeschlossen oder wurden nicht gefunden, bitte prüfen!
pause
}

Set-StrictMode -Version "2.0"
Clear-Host

$Drives=[System.Io.DriveInfo]::GetDrives()

$ComputerName = Get-Content Env:ComputerName

$Width_0=3
$Width_1=15
$Width_2=20
$Width_3=13
$Width_4=6+$ComputerName.Length

#Tabellenüberschrift definieren
$HeadLine = "{0,$Width_0} {1,$($Width_1):0.00} {2,$($Width_2):0.00} {3,$($Width_3):0.0%}" -f `
             "Drive","Totalsize in GB","TotalFreeSpace in GB","Percentfree"

#Tabellenüberschrift ausgeben
Write-Host -BackgroundColor DarkYellow -foregroundcolor DarkRed "$HeadLine`n"
    
$Drives | ForEach {
  If ($_.TotalSize -gt 0){  #damit unverbundene LW nicht angezeigt werden
     $Drivename = $_.name
     $Totalsize = $($_.Totalsize)/1GB
     $TotalFreeSpace = $($_.TotalFreeSpace)/1GB
     $PercentFree = $($_.TotalFreeSpace)/$($_.Totalsize)
     
    #Ausgabe
    "{0,$Width_0} {1,$($Width_1):0.00} {2,$($Width_2):0.00} {3,$($Width_3):0.0%} " -f `
         $Drivename,$Totalsize,$TotalFreeSpace,$PercentFree
  }Else{
     $Drivename = $_.name
     $ComputerName = Get-Content env:ComputerName
      "{0}" -f $Drivename
  }
}

Write-Host Freier Speicherplatz der angeschlossenen Festplatten.
pause