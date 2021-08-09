# .config

A series of utilities for setting up a Unix or Windows system automatically

## Usage

You can use the quick-install method, by running the relevant command for your system.

If you want to customize the script for your needs, download the relevant script for your operating system and then follow [configuration](#Configuration).

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

Once installed, follow the [Unix](#unix) instructions to configure the WSL distribution(s) you selected!

### Unix

Run the following command from your operating system's shell/terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/chrisdmacrae/.config/main/install.sh)"
```

## Configuration

Each script follows a pretty similar convention. For basic configuration, edit everything _above_:

```shell
## Script Logic
## Only modify after this point if you know what you're doing!
```

### Windows

The Windows scripts install applications, tools, and libraries using [chocolatey](https://chocolatey.org/), and will auto-install it if it is not present. You can learn [how to use chocolatey](https://chocolatey.org/install) for fine-grained control of your installations, including upgrading and uninstallation.

---

For Windows, edit the `$APP_NAMES` variable list to add or remove new lines with the app identifier of the app you wish to support installing. You can use any app identifier from the [chocolatey packages registry](https://community.chocolatey.org/packages?page=2&prerelease=False).

### Unix

The Unix script uses [homebrew](https://brew.sh/) to install apps and tools, and [`asdf`] to install libraries. You can learn [how to use homebrew]() for fine-grained control of your app and tool installations, including upgrading and uninstallation. You can learn [how to use `asdf`]() for fine-grained control of your libraries, including upgrading, supporting multiple versions of libraries on the same machine, and uninstallation.

---

For Unix, there are three variables you can edit:

#### Apps
`APP_NAMES`

These are GUI apps (think: IDE) that you can install. Edit the list to add or remove new lines with the app identifier of the app you wish to support installing.

You can use any identifier from the [homebrew registry](https://formulae.brew.sh/).

#### CLI Tools
`TOOL_NAMES`

These are CLI apps (think: Github CLI) that you can install. Edit the list to add or remove new lines with the app identifier of the tools you wish to support installing.

You can use any identifier from the [homebrew registry](https://formulae.brew.sh/).

#### Libraries
`LIBRARIES`

These are libraries and software development kits (think: NodeJS) that you can install. Edit the list to add or remove new lines with the library identifier of the tools you wish to support installing. The format for these is different than tools or app names.

`library-name#download-url`:
- `library-name` is the name of the `asdf` plugin
- `download-url` is the URL to download the plugin, separated from the library name with a `#`.

Given you wanted to add support for NodeJS, you would go to the plugin installation instructions, and find a line that looks like:

```shell
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
```

You use `nodejs` as `library-name` and `https://github.com/asdf-vm/asdf-nodejs.git` as the download URL

You can find a list of asdf libraries, which should include the install instructions, [here](https://github.com/asdf-community).

- _Note: do not add commas after each item in any of the lists_