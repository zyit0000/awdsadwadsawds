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

CHECK="${GREEN}âœ”${NC}"
CROSS="${RED}âœ–${NC}"
INFO="${CYAN}âžœ${NC}"
WARN="${YELLOW}âš ${NC}"

DYLIB_URL="https://x099xkycxe.ufs.sh/f/ar75CUBjeUn9nigUdemSgvfklQ1HiDw8OodZVnM9G4aYPCe3"
MODULES_URL="https://x099xkycxe.ufs.sh/f/ar75CUBjeUn9TL8xp2unI8k92VmFY0fHB1oRQPUjZhwLsxuJ"
UI_URL="https://x099xkycxe.ufs.sh/f/ar75CUBjeUn9803fxsbTwzvAKl3Z2nrXRk6SWeCQhBYqjfE9"

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
@@@@@@@@@@@@@@#.:=*%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%#*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@-:-+%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
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

    curl -# --fail --show-error -L --retry 3 --retry-delay 1 "$url" -o "$output"
    [ -s "$output" ]
}

extract_zip() {
    local archive="$1"
    local dest="$2"

    unzip -tq "$archive" >/dev/null 2>&1
    unzip -oq "$archive" -d "$dest"
}

install_dylib() {
    local archive="$TEMP/lib.zip"
    local target="$APP_DIR/Roblox.app/Contents/Resources/libOpiumware.dylib"

    download_file "$DYLIB_URL" "$archive"

    if extract_zip "$archive" "$TEMP"; then
        [ -f "$TEMP/libOpiumware.dylib" ]
        mv "$TEMP/libOpiumware.dylib" "$target"
        return 0
    fi

    if file "$archive" 2>/dev/null | grep -qi 'Mach-O'; then
        mv "$archive" "$target"
        return 0
    fi

    echo "Downloaded lib asset is not a valid zip or dylib." >&2
    file "$archive" >&2 || true
    return 1
}

download_roblox() {
    download_file "https://setup.rbxcdn.com/mac/$version-RobloxPlayer.zip" "$TEMP/RobloxPlayer.zip"
    extract_zip "$TEMP/RobloxPlayer.zip" "$TEMP"
    mv "$TEMP/RobloxPlayer.app" "$APP_DIR/Roblox.app"
    xattr -cr "$APP_DIR/Roblox.app"
    codesign --remove-signature "$APP_DIR/Roblox.app/Contents/MacOS/RobloxPlayer"
}

install_modules() {
    install_dylib

    download_file "$MODULES_URL" "$TEMP/modules.zip"
    extract_zip "$TEMP/modules.zip" "$TEMP"

    "$TEMP/Resources/Injector" \
        "$APP_DIR/Roblox.app/Contents/Resources/libOpiumware.dylib" \
        "$APP_DIR/Roblox.app/Contents/MacOS/libmimalloc.3.dylib" \
        --strip-codesig --all-yes >/dev/null 2>&1

    mv "$APP_DIR/Roblox.app/Contents/MacOS/libmimalloc.3.dylib_patched" \
       "$APP_DIR/Roblox.app/Contents/MacOS/libmimalloc.3.dylib"
    rm -rf "$APP_DIR/Roblox.app/Contents/MacOS/RobloxPlayerInstaller.app"
    codesign --force --deep --sign - "$APP_DIR/Roblox.app"

    download_file "$UI_URL" "$TEMP/ui.zip"
    extract_zip "$TEMP/ui.zip" "$TEMP"
    mv -f "$TEMP/Opiumware.app" "$APP_DIR/Opiumware.app"

    codesign --force --deep --sign - "$APP_DIR/Opiumware.app"

    mkdir -p ~/Opiumware/{workspace,autoexec,themes,modules}
    mkdir -p ~/Opiumware/modules/{decompiler,LuauLSP}

    mv -f "$TEMP/Resources/Decompiler" ~/Opiumware/modules/decompiler/Decompiler
    mv -f "$TEMP/Resources/LuauLSP" ~/Opiumware/modules/LuauLSP/LuauLSP
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
    version="version-1d604bb8b63849b4"
    echo -e "${INFO} Version: ${BOLD}$version${NC}"

    section "Downloading Roblox"
    run_step "Downloading Roblox" download_roblox

    section "Installing Opiumware"
    run_step "Installing modules" install_modules

    echo
    echo -e "${GREEN}${BOLD}Installation complete.${NC}"

    open "$APP_DIR/Roblox.app"
    open "$APP_DIR/Opiumware.app"
}

main
