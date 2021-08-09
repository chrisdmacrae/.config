#!/bin/bash
# Install script for Unix-based systems

## Script Inputs and Logic
APP_NAMES=(
    'visual-studio-code'
    'spotify'
    'slack'
    'rubymine'
    'rider'
    'goland'
    'clion'
    'rectangle'
)

TOOL_NAMES=(
    'gh'
    'asdf'
    'ngrok'
)

LIBRARIES=(
    "nodejs#https://github.com/asdf-vm/asdf-nodejs.git"
    "ruby#https://github.com/asdf-vm/asdf-ruby.git"
)

function Prompt-YesNo() {
    message=$1
    read -r -p "$message [Y]es/[N]o: " answer
    
    if [[ "$answer" =~ ^[Yy]$ ]]; then 
        echo true
    else
        echo false
    fi
}

function InstallMany() {
    prompt=$1
    type=$2
    shift
    shift
    appNames=( "$@" )

    for appName in "${appNames[@]}"; do
        name="${appName%%#*}"
        source="${appName##*#}"

        if $prompt; then
            result=$(Prompt-YesNo "Would you like to install $name?")
            if ! $result; then
                continue
            else
                Install "$type" "$name" "$source"
            fi
        else
            Install "$type" "$name" "$source"
        fi
    done
}

function Install() {
    type=$1
    appName=$2
    source=$3

    {
        if [ "$type" = 'app' ]; then
            brew install --cask "$appName"
        elif [ "$type" = 'tool' ]; then
            brew install "$appName"
        elif [ "$type" = 'library' ]; then
            asdf plugin add "$appName" "$source"
            asdf install "$appName" latest
        fi
    } || {
        echo "Failed to install $appName"
    }
}

## Script Execution
echo "Welcome to .config"

### Install OhMyZsh
hash uninstall_oh_my_zsh > /dev/null
if [ $? -eq 0 ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

### Install apps and tools
shouldPrompt=$(Prompt-YesNo "Would you like to choose which applications and tools to install? If not, all will be auto-installed.")
InstallMany "$shouldPrompt" "app" "${APP_NAMES[@]}"
InstallMany "$shouldPrompt" "tool" "${TOOL_NAMES[@]}"
InstallMany "$shouldPrompt" "library" "${LIBRARIES[@]}"

### Halt exit until user input
read -r -p "Press any key to exit"
