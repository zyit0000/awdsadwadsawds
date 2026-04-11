#!/usr/bin/env bash

# Opiumware Ultimate Installer (Combined & Fixed)
# Developed by @norbyv1
# Refined by Antigravity AI

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

# Fallback for older macOS versions
VERSION_MAJOR="$(sw_vers -productVersion | awk -F. '{print $1}')"
if [ "$VERSION_MAJOR" -lt 11 ]; then
    UI_URL="https://x099xkycxe.ufs.sh/f/ar75CUBjeUn973Un5SgiSg2Cb3OUYDHqn5ozMk0fmAtRrcsx"
fi

# Target Roblox Client Version
ROBLOX_VERSION="version-08d2b9589bf14135"

# --- Functions ---

banner() {
    clear
    echo -e "${BOLD}${CYAN}"
    cat <<'EOF'
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%*=--::=*@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#+-:..........:+@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@@@@@@@#+-:..............-+@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@%#=-:...:-=+*#%%%#*-.:=*@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##*=-:.::=*#@@@@@@@@@@@@+-#@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#+-..:-+%@@@@@@@@@@@@@@@@#*@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%+=:.:=*%@@@@@@@@@@@@@@@@@@@+@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*+-.:=*%@@@@@=%@@@@@@@@@@@@@@#@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*+:.-##@@@@@@@@@@#=@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%*=::+#%@@@@@@@@@@@@@@*:#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%**==*#@@@@@@@@@@@@@@@@@@@*-:@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%#=-*%@@@@@@@@@@@@@@@@@@@@@@%+-+=@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@%#+=*%@@@@@@@@@@@@@@@@@@@@@@@@@++===**#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@%#*=+#@@@@@@@@@@@@@@@@@@@@@@@@@@@=::---=++###%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@##+-*%@@@@@@@@@@@@@@@@@@@%%%##*+=-=------=++===+***+*##%%%%%@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@**-+%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%%%#*+=-=+++******%%%@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@-+-+%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%#+=+**#*%@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@-=:+%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%***#*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@#.:=*%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%#*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@-:-+%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%*@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@*=----@@@@@%##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@%%%%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
EOF
    echo -e "${NC}"
    echo -e "${BLUE}=[ Opiumware Ultimate Installer ]=${NC}"
    echo -e "${CYAN}Developed by @norbyv1 | Verified & Fixed${NC}\n"
}

run_step() {
    local msg="$1"
    shift
    echo -ne "${CYAN}[...]${NC} $msg\r"
    if "$@" >/dev/null 2>&1; then
        printf "\r\033[K${GREEN}${CHECK} %s${NC}\n" "$msg"
    else
        printf "\r\033[K${RED}${CROSS} %s Failed${NC}\n" "$msg"
        exit 1
    fi
}

section() {
    echo -e "\n${BOLD}${CYAN}==> $1${NC}"
}

# --- Main Script ---

main() {
    banner

    # 1. Directory Detection
    if [ -w "/Applications" ]; then
        APP_DIR="/Applications"
        echo -e "${INFO} Target: /Applications"
    else
        APP_DIR="$HOME/Applications"
        mkdir -p "$APP_DIR"
        echo -e "${WARN} Target: $APP_DIR (No root access)"
    fi

    TEMP="$(mktemp -d)"
    trap 'rm -rf "$TEMP"' EXIT

    # 2. Cleanup
    section "Preparing Environment"
    run_step "Killing existing processes" bash -c "killall -9 RobloxPlayer Opiumware 2>/dev/null || true"
    
    for target in "$APP_DIR/Roblox.app" "$APP_DIR/Opiumware.app"; do
        if [ -e "$target" ]; then
            run_step "Removing old $(basename "$target")" rm -rf "$target"
        fi
    done

    rm -rf ~/Opiumware/modules/LuauLSP ~/Opiumware/modules/decompiler 2>/dev/null || true
    rm -f ~/Opiumware/modules/update.json 2>/dev/null || true

    # 3. Roblox Installation
    section "Installing Roblox"
    echo -e "${INFO} Version: ${BOLD}$ROBLOX_VERSION${NC}"
    
    run_step "Downloading Roblox Player" curl -# -L "https://setup.rbxcdn.com/mac/$ROBLOX_VERSION-RobloxPlayer.zip" -o "$TEMP/RobloxPlayer.zip"
    run_step "Extracting Roblox" unzip -oq "$TEMP/RobloxPlayer.zip" -d "$TEMP"
    run_step "Moving to Applications" mv "$TEMP/RobloxPlayer.app" "$APP_DIR/Roblox.app"
    run_step "Removing quarantine" xattr -cr "$APP_DIR/Roblox.app"
    run_step "Stripping signature" codesign --remove-signature "$APP_DIR/Roblox.app/Contents/MacOS/RobloxPlayer"

    # 4. Opiumware Core Modules
    section "Installing Opiumware Core"
    
    run_step "Downloading Dylib" curl -# -L "$DYLIB_URL" -o "$TEMP/lib.zip"
    run_step "Extracting Dylib" unzip -oq "$TEMP/lib.zip" -d "$TEMP"
    run_step "Installing Dylib" mv "$TEMP/libOpiumware.dylib" "$APP_DIR/Roblox.app/Contents/Resources/libOpiumware.dylib"

    run_step "Downloading Modules" curl -# -L "$MODULES_URL" -o "$TEMP/modules.zip"
    run_step "Extracting Modules" unzip -oq "$TEMP/modules.zip" -d "$TEMP"

    
    # Ensure Injector is executable and signed to prevent 'Killed: 9'
    run_step "Preparing Injector" chmod +x "$TEMP/Resources/Injector"
    run_step "De-quarantining Injector" bash -c "xattr -d com.apple.quarantine '$TEMP/Resources/Injector' 2>/dev/null || true"
    run_step "Ad-hoc signing Injector" bash -c "codesign --force --deep --sign - '$TEMP/Resources/Injector' 2>/dev/null || true"

    run_step "Injecting Dylib" "$TEMP/Resources/Injector" \
        "$APP_DIR/Roblox.app/Contents/Resources/libOpiumware.dylib" \
        "$APP_DIR/Roblox.app/Contents/MacOS/libmimalloc.3.dylib" \
        --strip-codesig --all-yes
    
    run_step "Committing patch" mv "$APP_DIR/Roblox.app/Contents/MacOS/libmimalloc.3.dylib_patched" \
        "$APP_DIR/Roblox.app/Contents/MacOS/libmimalloc.3.dylib"
    
    run_step "Cleaning installer junk" rm -rf "$APP_DIR/Roblox.app/Contents/MacOS/RobloxPlayerInstaller.app"
    run_step "Signing Roblox" codesign --force --deep --sign - "$APP_DIR/Roblox.app"

    # 5. Opiumware UI
    section "Installing User Interface"
    
    run_step "Downloading UI" curl -# -L "$UI_URL" -o "$TEMP/ui.zip"
    run_step "Extracting UI" unzip -oq "$TEMP/ui.zip" -d "$TEMP"
    run_step "Installing UI" mv -f "$TEMP/Opiumware.app" "$APP_DIR/Opiumware.app"
    run_step "Signing UI" codesign --force --deep --sign - "$APP_DIR/Opiumware.app"

    # 6. Support Folders & Modules
    section "Finalizing Setup"
    
    mkdir -p ~/Opiumware/{workspace,autoexec,themes,modules/decompiler,modules/LuauLSP}
    
    # Check for decompiler in Resources (might be capitalized or not)
    if [ -f "$TEMP/Resources/Decompiler" ]; then
        mv -f "$TEMP/Resources/Decompiler" ~/Opiumware/modules/decompiler/Decompiler
    elif [ -f "$TEMP/Resources/decompiler" ]; then
        mv -f "$TEMP/Resources/decompiler" ~/Opiumware/modules/decompiler/Decompiler
    fi
    
    if [ -f "$TEMP/Resources/LuauLSP" ]; then
        mv -f "$TEMP/Resources/LuauLSP" ~/Opiumware/modules/LuauLSP/LuauLSP
    fi

    run_step "Resetting permissions" bash -c "
        tccutil reset Accessibility com.Roblox.RobloxPlayer 2>/dev/null || true
        tccutil reset ScreenCapture com.norbyv1.opiumware 2>/dev/null || true
    "

    echo -e "\n${GREEN}${BOLD}${CHECK} Installation Successful!${NC}"
    echo -e "${YELLOW}${WARN} Reminder: Use an alt account to prevent main account bans.${NC}"
    
    open "$APP_DIR/Roblox.app"
    open "$APP_DIR/Opiumware.app"
}

main
