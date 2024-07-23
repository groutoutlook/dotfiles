# https://gist.github.com/milnak/88d66ea79df519e3f07a30ee10531d5a
Function Write-Config
{
  @'
Write-Host -ForegroundColor Yellow 'Adding config'
'@
  # NOTE: Required because 'scoop config' returns a PSCustomObject
  $config = scoop config
  $configs = $config | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | ForEach-Object { [PSCustomObject]@{ Name = $_; Value = $config.$_ } }

  $configs | Where-Object Name -notin @( 'alias', 'scoop_repo', 'last_update', 'scoop_branch' ) `
  | ForEach-Object { "scoop config $($_.Name) '$($_.Value)'" }
}


Function Write-Buckets
{
  @'
Write-Host -ForegroundColor Yellow 'Adding buckets'
'@
  # NOTE: Redirection neeed. See https://github.com/ScoopInstaller/Scoop/issues/5216
  $apps = scoop list 6> $null | Select-Object Source, Name | Sort-Object -Property @{ Expression = { $_.Source -eq 'main' }; Descending = $true }, Name

  # Determine what buckets we'll need
  # git is required for buckets
  'scoop install main/git'

  # main is installed by default
  $apps | Select-Object -Unique Source | Where-Object Source -ne 'main' | ForEach-Object {
    "scoop bucket add $($_.Source)"
  }
}

Function Write-Aliases
{
  # NOTE: This is required as 'scoop alias list' doesn't include descriptions
  # NOTE: How to get scoop home folder?
  $aliases = Get-ChildItem -LiteralPath "${env:HOMEDRIVE}${env:HOMEPATH}/scoop/shims" -File -Recurse -Filter 'scoop-*.ps1' `
  | Select-Object @{Name = 'Name'; Expression = { $_.BaseName.SubString(6) } }, @{Name = 'Command'; Expression = { Get-Content $_.FullName `
      | Select-String -Pattern '^# Summary: (.*)' -NotMatch }
  }, @{Name = 'Summary'; Expression = { (Get-Content $_.FullName | Select-String -Pattern '^# Summary: (.*)').Matches[0].Groups[1] } }

  @'
Write-Host -ForegroundColor Yellow 'Adding aliases'
'@

  $aliases | ForEach-Object {
    "scoop alias add '$($_.Name)' '$($_.Command)' '$($_.Summary)'"
  }
}
scoop install main/git
scoop bucket add extras
scoop bucket add java
scoop bucket add nonportable
scoop import ./scoopfile.json
scoop alias add 'add' 'scoop install $args[0]' 'Install app'
scoop alias add 'al' 'scoop alias list' 'List alias'
scoop alias add 'ca' 'scoop cleanup *' 'Delete all old installed versions; better exit running programs first'
scoop alias add 'cc' 'scoop cache rm *' 'Empty download cache'
scoop alias add 'i' 'foreach ($_ in $args) {scoop install $_}' 'Install apps'
scoop alias add 'ls' 'scoop list' 'List installed apps'
scoop alias add 'remove' 'scoop uninstall $args[0]' 'Uninstall an app'
scoop alias add 'rm' 'scoop uninstall $args[0]' 'Uninstall an app'
scoop alias add 's' 'scoop status' 'Show status and check for new app versions'
scoop alias add 'u' 'scoop update $args[0]' 'Update apps, or Scoop itself'
scoop alias add 'ua' 'scoop update *' 'Update all installed apps'
scoop alias add 'upgrade' 'scoop update $args[0]' 'Update apps, or Scoop itself'
scoop alias add 'w' 'scoop which $args[0]' ''
