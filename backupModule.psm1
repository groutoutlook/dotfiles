$backUpDir = @{
  "$env:kicadSettingDir" = "$env:dotfilesRepo\.kicad" 
  "$HOME\.config\jrnl" = "$env:dotfilesRepo\.config\jrnl"
}



function Backup-Extensive()
{

  foreach ($startDir in $backUpDir.Keys)
  {
    $destination = $($backUpDir.$startDir)
    Copy-Item -Path $startDir -Destination $destination -Force -Recurse
    Write-Host "$startDir backed up" -ForegroundColor Cyan 
  }
}
Set-Alias -Name backupdot -Value Backup-Extensive
