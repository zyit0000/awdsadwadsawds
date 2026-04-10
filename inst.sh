#!/usr/bin/env bash

# Opiumware v2.2.4 (Optimized & Fixed)
# Developed by @norbyv1

set -euo pipefail
IFS=$'\n\t'

# --- Colors & UI Elements ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

CHECK="${GREEN}✔${NC}"
CROSS="${RED}✖${NC}"
INFO="${CYAN}➜${NC}"
WARN="${YELLOW}⚠${NC}"

# --- Configuration ---
DYLIB_URL="https://x099xkycxe.ufs.sh/f/ar75CUBjeUn9XAxLsaTNtgWaiOBJXYsTUb2xuCSvQ8H3MLwG"
MODULES_URL="https://x099xkycxe.ufs.sh/f/ar75CUBjeUn9zb5N2U71NMWOXBTIwjKh0pvSDLcxH6FERayu"
UI_URL="https://q3p1xj20dh.ufs.sh/f/BrzckOVD7pCZXic4yblOrXx5SwcQKWkvE8P629ny4DmGCYVA"

VERSION_MAJOR="$(sw_vers -productVersion | awk -F. '{print $1}')"
[ "$VERSION_MAJOR" -lt 12 ] && UI_URL="https://x099xkycxe.ufs.sh/f/ar75CUBjeUn973Un5SgiSg2Cb3OUYDHqn5ozMk0fmAtRrcsx"

if [ -w "/Applications" ]; then
    APP_DIR="/Applications"
else
    APP_DIR="$HOME/Applications"
    mkdir -p "$APP_DIR"
fi

TEMP="$(mktemp -d)"
trap 'rm -rf "$TEMP"' EXIT

# --- Functions ---

spinner() {
    local msg="$1"
    local pid="$2"
    local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0
    while kill -0 "$pid" 2>/dev/null; do
        i=$(( (i+1) % 10 ))
        printf "\r${CYAN}[${spin:$i:1}]${NC} %s..." "$msg"
        sleep 0.1
    done
    wait "$pid"
    printf "\r${CHECK} %s - Completed\n" "$msg"
}

banner() {
    clear
    echo -e "${CYAN}${BOLD}== Opiumware (Intel) Installer ==${NC}"
    echo -e "${BLUE}Developed by @norbyv1 | Fixed version${NC}\n"
}

section() {
    echo -e "\n${BOLD}${CYAN}==> $1${NC}"
}

# --- Main Script ---

main() {
    banner

    section "Cleaning up environment"
    killall -9 RobloxPlayer Opiumware 2>/dev/null || true
    
    for target in "$APP_DIR/Roblox.app" "$APP_DIR/Opiumware.app"; do
        if [ -d "$target" ]; then
            rm -rf "$target" || sudo rm -rf "$target"
        fi
    done

    rm -rf ~/Opiumware/modules/LuauLSP ~/Opiumware/modules/decompiler 2>/dev/null || true

    section "Fetching version info"
    local roblox_version="version-08d2b9589bf14135"  
    echo -e "${INFO} Target: ${BOLD}$roblox_version${NC}"

    section "Downloading & Extracting Roblox"
    (
        curl -sL "https://setup.rbxcdn.com/mac/$roblox_version-RobloxPlayer.zip" -o "$TEMP/RobloxPlayer.zip"
        unzip -oq "$TEMP/RobloxPlayer.zip" -d "$TEMP"
        mv "$TEMP/RobloxPlayer.app" "$APP_DIR/Roblox.app"
        xattr -rd com.apple.quarantine "$APP_DIR/Roblox.app" 2>/dev/null || true
    ) & spinner "Downloading Roblox" $!

    section "Patching Modules"
    (
        # Dylib
        curl -sL "$DYLIB_URL" -o "$TEMP/libOpiumware.zip"
        unzip -oq "$TEMP/libOpiumware.zip" -d "$TEMP"
        mv "$TEMP/libOpiumware.dylib" "$APP_DIR/Roblox.app/Contents/Resources/libOpiumware.dylib"

        # Modules & Injector
        curl -sL "$MODULES_URL" -o "$TEMP/modules.zip"
        unzip -oq "$TEMP/modules.zip" -d "$TEMP"
        
        chmod +x "$TEMP/Resources/Injector"
        "$TEMP/Resources/Injector" "$APP_DIR/Roblox.app/Contents/Resources/libOpiumware.dylib" "$APP_DIR/Roblox.app/Contents/MacOS/libmimalloc.3.dylib" --strip-codesig --all-yes >/dev/null 2>&1
        
        mv "$APP_DIR/Roblox.app/Contents/MacOS/libmimalloc.3.dylib_patched" "$APP_DIR/Roblox.app/Contents/MacOS/libmimalloc.3.dylib"
        
        # UI Application
        curl -sL "$UI_URL" -o "$TEMP/OpiumwareUI.zip"
        unzip -oq "$TEMP/OpiumwareUI.zip" -d "$TEMP"
        mv -f "$TEMP/Opiumware.app" "$APP_DIR/Opiumware.app"
        
        # Support Folders
        mkdir -p ~/Opiumware/{workspace,autoexec,themes,modules/decompiler,modules/LuauLSP}
        if [ -f "$TEMP/Resources/Decompiler" ]; then
            mv "$TEMP/Resources/Decompiler" ~/Opiumware/modules/decompiler/Decompiler
        elif [ -f "$TEMP/Resources/decompiler" ]; then
            mv "$TEMP/Resources/decompiler" ~/Opiumware/modules/decompiler/Decompiler
        fi
        [ -f "$TEMP/Resources/LuauLSP" ] && mv "$TEMP/Resources/LuauLSP" ~/Opiumware/modules/LuauLSP/LuauLSP

        # Local Ad-hoc Signing
        codesign --force --deep --sign - "$APP_DIR/Roblox.app" 2>/dev/null || true
        codesign --force --deep --sign - "$APP_DIR/Opiumware.app" 2>/dev/null || true
        
        # Reset Permissions
        tccutil reset Accessibility com.Roblox.RobloxPlayer 2>/dev/null || true
        tccutil reset ScreenCapture com.norbyv1.opiumware 2>/dev/null || true
    ) & spinner "Installing Opiumware" $!

    echo -e "\n${GREEN}${BOLD}${CHECK} Installation complete.${NC}"
    echo -e "${YELLOW}${WARN} Notice: Use an alt account to prevent main account bans.${NC}"
    
    open "$APP_DIR/Roblox.app"
    open "$APP_DIR/Opiumware.app"
}

main

