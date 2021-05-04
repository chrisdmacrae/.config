# .config

A series of utilities for setting up a Unix or Windows system automatically

## Usage

You can use the quick-install method, by running the relevant command for your system.

### Windows

Run the following command from an admin-elevated powershell window\*:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/chrisdmacrae/.config/main/install.ps1'))
```

> \* You can start an elevated powershell window by:
> - Pressing `win` + `r`
> - Typing in `powershell`
> - And holding `ctrl` + `shift` and pressing `enter`

#### Windows Subsystem For Linux (WSL)

If you wish to install WSL(2), then you can run the following command from an admin-elevated powershell window:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/chrisdmacrae/.config/main/wsl2.ps1'))
```

> **Note:** this script will restart your computer once or twice and resume. Wait until the script re-opens after a restart and prompts you to close it before trying to use WSL.

Once installed, follow the [Unix](#unix) instructions to configure tje WSL distribution(s) you selected!

### Unix

```bash
TODO
```