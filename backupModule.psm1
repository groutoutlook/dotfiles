$backUpDir = @{
  "$env:APPDATA\kicad" = "$env:dotfilesRepo\config" 
  # "$HOME\PenTablet_Config.pcfg" = "$env:dotfilesRepo\config"
  "$HOME\.gitconfig" = "$env:dotfilesRepo\"
  "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_*\LocalState\settings.json" = "$env:dotfilesRepo\config\WindowsTerminal"
  "$env:usrbinD\mousemaster.properties" = "$env:dotfilesRepo\config\"
  "$HOME\Downloads\vimium_c*.json" = "$env:dotfilesRepo\config\vimium_c_edge.json"
}


function Backup-Extensive($Verbose = $null)
{
  foreach ($startDir in $backUpDir.Keys)
  {
    $destination = $($backUpDir.$startDir)
    # INFO: sanitized input to get latest files.
    $resolvedDir = (Resolve-Path $startDir)[-1]
    Copy-Item -Path $resolvedDir -Destination $destination -Force -Recurse
    
    if($Verbose -le 0)
    {
      $startDir = Format-LimitLength $startDir
    }
    Write-Host "$startDir backed up" -ForegroundColor Cyan 
  }
}
Set-Alias -Name backupdot -Value Backup-Extensive
