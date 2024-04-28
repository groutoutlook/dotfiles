$backUpDir = @{
  "$env:kicadSettingDir" = "$env:dotfilesRepo\.config\.kicad" 
  "$HOME\PenTablet_Config.pcfg" = "$env:dotfilesRepo\.config\PenTablet_Config.pcfg"
  "$env:APPDATA\copyq" = "$env:dotfilesRepo\.config\"
  "$HOME\.gitconfig" = "$env:dotfilesRepo\"
  "$HOME\.gitignore_global" = "$env:dotfilesRepo\"
  "$HOME\.config\jrnl" = "$env:dotfilesRepo\.config\"
  "$HOME\.config\starship.toml" = "$env:dotfilesRepo\.config\"
  "$env:APPDATA\helix" = "$env:dotfilesRepo\.config\"
  "$HOME\.vimrc" = "$env:dotfilesRepo\.config\vim"
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
