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
run *args: clean_old_ptoy
    :bak && git rap 

[script]
clean_old_ptoy:
    gci settings_* -Recurse -Depth 1 | sort -property LastWriteTime `
    | select -skiplast 1 | rm -Recurse -Force
    

alias b := build
build:
    :bak && git cif

format:
    biome format --write
