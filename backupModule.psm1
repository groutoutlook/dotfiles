$backUpDir = @{
  "$env:kicadSettingDir" = "$env:dotfilesRepo\.kicad" 
  "$HOME\.config\jrnl" = "$env:dotfilesRepo\.config\jrnl"
  "$HOME\PenTablet_Config.pcfg" = "$env:dotfilesRepo\PenTablet_Config.pcfg"
  "$env:APPDATA\copyq" = "$env:dotfilesRepo\"
}


function Backup-Extensive($Verbose = $null)
{
  foreach ($startDir in $backUpDir.Keys)
  {
    $destination = $($backUpDir.$startDir)
    Copy-Item -Path $startDir -Destination $destination -Force -Recurse
    if($Verbose -le 0)
    {
      $startDir = Format-LimitLength $startDir
    }
    Write-Host "$startDir backed up" -ForegroundColor Cyan 
  }
}
Set-Alias -Name backupdot -Value Backup-Extensive
