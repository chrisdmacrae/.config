# Install script for Windows-based systems

## Script Inputs and Logic
$APP_NAMES = @(
    'git',
    'gh',
    'github-desktop',
    'visualstudiocode',
    'jetbrains-rider',
    'visualstudiocode',
    'dotnetcore-sdk',
    'nodejs',
    'ruby',
    'slack',
    'microsoft-windows-terminal',
    'spotify'
)

function Prompt-YesNo($title, $message) {
    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","Description."
    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No","Description."
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
    $result = $host.ui.PromptForChoice($title, $message, $options, 1)

    return $result
}

function InstallApps($appNames, $prompt) {
    $appNames | ForEach-Object {
        $shouldInstall = $true

        if ($prompt) {
            $result = Prompt-YesNo(
                $_ + ":",
                "would you like to install $_" + "?"
            )

            if ($result -eq 1) {
                $shouldInstall = $false
            }
        }

        if ($shouldInstall) {
            InstallApp $_
        }
    }
}

Function InstallApp($appName) {
    try {
        choco feature enable -n allowGlobalConfirmation

        choco install $appName

        choco feature disable -n allowGlobalConfirmation
    }
    Catch {
        Write-Output "Failed to install $appName"
    }
}

Function Test-CommandExists($command) {
 $exists = $false
 $oldPreference = $ErrorActionPreference
 $ErrorActionPreference = 'stop'

 try {
    if (Get-Command $command) {
        $exists = $true
    }
  }
  Catch {
    $exists = $false
  }

  Finally {
    $ErrorActionPreference = $oldPreference
  }

  return $exists
}

## Script Execution

Write-Output "Welcome to .config"

### Install Chocolatey
$HAS_CHOCOLATEY = Test-CommandExists 'choco'
if (!$HAS_CHOCOLATEY) {
  Invoke-Expression ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
  Set-Variable PATH="%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
}

### Install apps and tools
$shouldPrompt = Prompt-YesNo(
    "Select apps?",
    "Would you like to choose which applications and tools to install? If not, all will be auto-installed."
) -eq 1
InstallApps $APP_NAMES $shouldPrompt

Read-Host -Prompt "Press any key to exit"