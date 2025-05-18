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
run *args:
    :bak && git rap 


alias b := build
build:
    :bak && git cif

format:
    biome format --write
