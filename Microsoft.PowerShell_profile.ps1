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
    Write-Host "λ " -NoNewline -ForegroundColor Green
    return " "
}
#
# Set "aliases". ls function requires: sudo cp /usr/bin/ls /usr/bin/ll
#
function edge {
    microsoft-edge-beta &> /dev/null &
}
function ls ($loc = '.') {
    if (-not (which lp)) {
        Write-Host "This command is overriden. I need sudo permission to make this work"
        sudo cp /usr/bin/ls /usr/bin/lp
    }
    $env:LS_COLORS = 'di=01;35:fi=00;96:*.ps1=00;94:*.py=00;33'
    lp $loc -X --color
}
function venv {
    if (Test-Path .venv) {
        ./.venv/bin/Activate.ps1
    } else {
        Write-Host "No virtual environment folder"
    }
}

# Set starting point to home
Set-Location

