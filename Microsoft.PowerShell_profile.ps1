#
# Set prompt
#
function prompt {
    Write-Host 'λ ' -NoNewline -ForegroundColor Green
    return ' '
}
#
# set commands
#
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
