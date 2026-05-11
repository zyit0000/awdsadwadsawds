#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

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

# Updated URLs
DYLIB_URL="https://x099xkycxe.ufs.sh/f/ar75CUBjeUn9suoxx7NRLpwIiVkxYvTUQnAuFbGoSEH1tPMO"
MODULES_URL="https://x099xkycxe.ufs.sh/f/ar75CUBjeUn9xXaWrFvIpMwWQxsnHTt2V4BR3zyoFfE0AGjZ"
UI_URL="https://x099xkycxe.ufs.sh/f/ar75CUBjeUn9T4nznlunI8k92VmFY0fHB1oRQPUjZhwLsxuJ"

VERSION="$(sw_vers -productVersion | awk -F. '{print $1}')"
if [ "$VERSION" -lt 11 ]; then
    UI_URL="https://x099xkycxe.ufs.sh/f/ar75CUBjeUn973Un5SgiSg2Cb3OUYDHqn5ozMk0fmAtRrcsx"
fi

TEMP=""
APP_DIR=""

section() {
    echo
    echo -e "${BOLD}${CYAN}==> $1${NC}"
}

run_step() {
    local msg="$1"
    shift

    echo -ne "${CYAN}[...]${NC} $msg\r"

    if "$@"; then
        printf "\r\033[K${GREEN}${CHECK} %s${NC}\n" "$msg"
    else
        printf "\r\033[K${RED}${CROSS} %s${NC}\n" "$msg"
        exit 1
    fi
}

banner() {
    clear
    echo -e "${BOLD}"
    cat <<'EOF'
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%*=--::=*@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#+-:..........:+@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@@@@@@@#+-:..............-+@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@%#=-:...:-=+*#%%%#*-.:=*@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##*=-:.::=*#@@@@@@@@@@@@+-#@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#+-..:-+%@@@@@@@@@@@@@@@@#*@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%+=:.:=*%@@@@@@@@@@@@@@@@@@@+@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*+-.:=*%@@@@@=%@@@@@@@@@@@@@@#@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*+:.-##@@@@@@@@@@#=@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%*=::+#%@@@@@@@@@@@@@@*:#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%**==*#@@@@@@@@@@@@@@@@@@@*-:@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%#=-*%@@@@@@@@@@@@@@@@@@@@@@%+-+=@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@%#+=*%@@@@@@@@@@@@@@@@@@@@@@@@@++===**#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@%#*=+#@@@@@@@@@@@@@@@@@@@@@@@@@@@=::---=++###%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@##+-*%@@@@@@@@@@@@@@@@@@@%%%##*+=-=------=++===+***+*##%%%%%@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@**-+%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%%%#*+=-=+++******%%%@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@-+-+%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%#+=+**#*%@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@-=:+%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%***#*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@#.:=*%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%#*@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@-:-+%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%*@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@*=----@@@@@%##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@%%%%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
EOF
    echo -e "${NC}"
    echo -e "${BLUE}=[ Opiumware Installer ]=${NC}"
    echo -e "${CYAN}Developed by @norbyv1${NC}\n"
}

cleanup() {
    if [ -n "${TEMP:-}" ] && [ -d "$TEMP" ]; then
        rm -rf "$TEMP"
    fi
}

download_file() {
    local url="$1"
    local output="$2"
    url="${url%$'\r'}"
    curl -# --fail --show-error -L --retry 3 --retry-delay 1 "$url" -o "$output" || return 1
    [ -s "$output" ] || return 1
}

extract_zip() {
    local archive="$1"
    local dest="$2"
    unzip -tq "$archive" >/dev/null 2>&1 || return 1
    unzip -oq "$archive" -d "$dest" || return 1
}

install_dylib() {
    local archive="$TEMP/lib.zip"
    local target="$APP_DIR/Roblox.app/Contents/Resources/libOpiumware.dylib"
    download_file "$DYLIB_URL" "$archive" || return 1
    if extract_zip "$archive" "$TEMP" 2>/dev/null; then
        [ -f "$TEMP/libOpiumware.dylib" ] || return 1
        mv "$TEMP/libOpiumware.dylib" "$target" || return 1
        return 0
    fi
    if file "$archive" 2>/dev/null | grep -qi 'Mach-O'; then
        mv "$archive" "$target" || return 1
        return 0
    fi
    return 1
}

download_roblox() {
    download_file "https://setup.rbxcdn.com/mac/$version-RobloxPlayer.zip" "$TEMP/RobloxPlayer.zip" || return 1
    extract_zip "$TEMP/RobloxPlayer.zip" "$TEMP" || return 1
    mv "$TEMP/RobloxPlayer.app" "$APP_DIR/Roblox.app" || return 1
    xattr -cr "$APP_DIR/Roblox.app" || true
    codesign --remove-signature "$APP_DIR/Roblox.app/Contents/MacOS/RobloxPlayer" || return 1
}

install_modules() {
    install_dylib || return 1
    download_file "$MODULES_URL" "$TEMP/modules.zip" || return 1
    extract_zip "$TEMP/modules.zip" "$TEMP" || return 1
    "$TEMP/Resources/Injector" \
        "$APP_DIR/Roblox.app/Contents/Resources/libOpiumware.dylib" \
        "$APP_DIR/Roblox.app/Contents/MacOS/libmimalloc.3.dylib" \
        --strip-codesig --all-yes >/dev/null 2>&1 || return 1
    mv "$APP_DIR/Roblox.app/Contents/MacOS/libmimalloc.3.dylib_patched" \
       "$APP_DIR/Roblox.app/Contents/MacOS/libmimalloc.3.dylib" || return 1
    rm -rf "$APP_DIR/Roblox.app/Contents/MacOS/RobloxPlayerInstaller.app" || true
    codesign --force --deep --sign - "$APP_DIR/Roblox.app" || return 1
    download_file "$UI_URL" "$TEMP/ui.zip" || return 1
    extract_zip "$TEMP/ui.zip" "$TEMP" || return 1
    mv -f "$TEMP/Opiumware.app" "$APP_DIR/Opiumware.app" || return 1
    codesign --force --deep --sign - "$APP_DIR/Opiumware.app" || return 1
    mkdir -p ~/Opiumware/{workspace,autoexec,themes,modules} || return 1
    mkdir -p ~/Opiumware/modules/{decompiler,LuauLSP} || return 1
    mv -f "$TEMP/Resources/Decompiler" ~/Opiumware/modules/decompiler/Decompiler || return 1
    mv -f "$TEMP/Resources/LuauLSP" ~/Opiumware/modules/LuauLSP/LuauLSP || return 1
}

main() {
    trap cleanup EXIT
    banner
    if [ -w "/Applications" ]; then
        APP_DIR="/Applications"
        echo -e "${INFO} Installing to /Applications"
    else
        APP_DIR="$HOME/Applications"
        mkdir -p "$APP_DIR"
        echo -e "${WARN} Using $APP_DIR (no root access)"
    fi
    TEMP="$(mktemp -d)"
    run_step "Killing Roblox Processes" bash -c "killall -9 RobloxPlayer Opiumware 2>/dev/null || true"
    section "Cleaning old installs"
    for target in "$APP_DIR/Roblox.app" "$APP_DIR/Opiumware.app"; do
        if [ -e "$target" ]; then
            run_step "Removing $(basename "$target")" rm -rf "$target"
        fi
    done
    rm -rf ~/Opiumware/modules/LuauLSP ~/Opiumware/modules/decompiler
    rm -f ~/Opiumware/modules/update.json 2>/dev/null || true

    section "Fetching client version"
    # Logic to fetch the version string from your GitHub file
    version=$(curl -s https://raw.githubusercontent.com/norbyv1/OpiumwareInstall/refs/heads/main/inst | grep -oE "version-[a-f0-9]+")
    
    if [[ -z "$version" ]]; then
        echo -e "${RED}${CROSS} Failed to fetch version from GitHub.${NC}"
        exit 1
    fi
    echo -e "${INFO} Version: ${BOLD}$version${NC}"

    section "Downloading Roblox"
    run_step "Downloading Roblox" download_roblox
    section "Installing Opiumware"
    run_step "Installing modules" install_modules
    echo
    echo -e "${GREEN}${BOLD}Installation complete.${NC}"
    open "$APP_DIR/Roblox.app" || true
    open "$APP_DIR/Opiumware.app" || true
}

main
