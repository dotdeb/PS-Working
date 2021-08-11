#
#   This profile is meant to run in wlsg Ubuntu.
#

#
# Set prompt
#
function prompt {
    $branch = git branch --show-current
    if (-not [string]::IsNullOrEmpty($branch)) {
        $origin = (git remote get-url origin).split('/', 3)[-1]
        Write-Host "($origin) " -NoNewline -ForegroundColor Blue   
        Write-Host "($branch) " -ForegroundColor Red
    }
    Write-Host 'λ ' -NoNewline -ForegroundColor Green
    return ' '
}
#
# Set "aliases". ls function requires: sudo cp /usr/bin/ls /usr/bin/ll
#
function edge {
    Invoke-Expression microsoft-edge-beta &> /dev/null &
}
function ls ($loc = '.') {
    if (-not (which lp)) {
        Write-Host 'This command is overriden. I need sudo permission to make this work (I copy ls to lp)'
        sudo cp /usr/bin/ls /usr/bin/lp
    }
    $env:LS_COLORS = 'di=01;35:fi=00;96:*.ps1=00;94:*.py=00;33'
    lp $loc -X --color
}
function venv {
    if (Test-Path .venv) {
        ./.venv/bin/Activate.ps1
    }
    else {
        Write-Host 'No virtual environment folder'
    }
}
#
# Common work tools I need to run once
#
function Init {
    if (-not (which teams)) {
        Write-Host 'No teams installed. Download .deb)' -ForegroundColor Green
        curl https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.4.00.7556_amd64.deb -o ~/Downloads/teams.deb
        Write-Host 'I need sudo priv to run apt install teams.deb' -ForegroundColor Green
        sudo apt install $env:HOME/Downloads/teams.deb
    }
    if (-not (which az)) {
        Write-Host 'No az-cli installed. Run install script)' -ForegroundColor Green
        curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    }
}

# Set starting point to home
Set-Location
