shebang := if os() == 'windows' { 'pwsh.exe' } else { '/usr/bin/env pwsh' }
set shell := ["pwsh", "-c"]
set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]
set script-interpreter := ["pwsh.exe", "-NoLogo", "-Command"]
set dotenv-load
set unstable
# set dotenv-filename	:= ".env"
# set dotenv-required := true
_default:
    @just --list

alias r := run
default_args := 'args here'
run *args="cif": _clean_old_ptoy _fetch_new_vimium _backup_old && (deploy args)
    "Deploy actually..."

[script]
_clean_old_ptoy:
    gci settings_* -Recurse -Depth 1 | sort -property LastWriteTime `
    | select -skiplast 1 | rm -Recurse -Force
    
[script]
_fetch_new_vimium:
    gci -Path ~/Downloads -Filter vimium_c* -Recurse -Depth 1 | sort -property LastWriteTime `
    | select -skiplast 1 | rm -Recurse -Force
    cp ~/Downloads/vimium_c* ./config/vimium_c_edge.json
    
alias b := build
build *args: _clean_old_ptoy _fetch_new_vimium _backup_old
    git cif

format:
    biome format --write

alias d := deploy
deploy args="cif":
    git {{args}}

alias crlf := crlf-to-lf
[script]
crlf-to-lf args="toml":
    foreach($file in (gci "*{{args}}" -recurse )){((Get-Content $file) -join "`n") + "`n" | Set-Content -NoNewline $file}


[script]
_backup_old:
    cp "$env:LOCALAPPDATA/Packages/Microsoft.WindowsTerminalPreview_*/LocalState/settings.json" "$env:dotfilesRepo/config/WindowsTerminal"
    cp "$env:HOME/.gitconfig" .