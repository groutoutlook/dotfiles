shebang := if os() == 'windows' { 'pwsh.exe' } else { '/usr/bin/env pwsh' }
set shell := ["pwsh", "-c"]
set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]
set dotenv-load := true
# set dotenv-filename	:= ".env"
# set dotenv-required := true
# INFO: if you want to edit the justfile use js -e.

help:
    @just --list -f "{{home_directory()}}/justfile"

default_arg := 'TODO:'
todo todo=default_arg:
    @rg {{todo}} -g '!justfile' -g "!third_party" 

hello:
    @Write-Host "Hello, world!" -ForegroundColor Yellow

placeholder:
    #!{{ shebang }}
    Write-Host "Havent written build task for this repo." -ForegroundColor Red
    if($env:pwsh_env) {Write-Host "$env:pwsh_env"}
    else {Write-Host "Apparently no .env as well" -ForegroundColor Yellow}

# INFO: basic `run` recipe.
alias r := run
default_args := 'args here'
run args=default_args:
    @Write-Host {{default_args}} -ForegroundColor Red


alias b := build
default_args_build := 'wip'
build args=default_args_build: 
    #!{{ shebang }}
    cp "$HOME\Downloads\vimium_c*.json" $env:dotfilesRepo\config\vimiumc.json
    if (( (fd settings_[\d]+).PSObject.TypeNames -contains "System.Array" ) -eq $true ){
        rm (fd settings_[\d]+)[0]
        Write-Host "new PowerToys settings" -ForegroundColor Blue
    }
    :bak
    if ( "{{default_args_build}}" -eq "wip" ){
        git suup && git wipp
    }
    else{
        Write-Host "rap it" -ForegroundColor Red
        git rap
    }
    
br:
    just build rap
    @Write-Host "Rap it" -ForegroundColor Red
