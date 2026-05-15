#!/bin/bash
# ================================================================
#   Anon's Gameux Toolkit
#   c0d3d By @non G00nz
#   Built for Bazzite OS (Fedora Atomic / rpm-ostree)
# ================================================================

# ---------- Colors ----------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BLUE='\033[0;34m'
WHITE='\033[1;37m'
BOLD='\033[1m'
ORANGE='\033[0;33m'
NC='\033[0m'

# ---------- Global Missing Arrays ----------
ALL_MISSING_FLATPAK=()
ALL_MISSING_RPM=()
ALL_MISSING_BREW=()
ALL_MISSING_UJUST=()

# ================================================================
#   BANNER
# ================================================================
print_banner() {
    clear
    echo -e "${RED}"
    echo "    ██████╗  █████╗ ███╗   ███╗███████╗██╗   ██╗██╗  ██╗"
    echo "   ██╔════╝ ██╔══██╗████╗ ████║██╔════╝██║   ██║╚██╗██╔╝"
    echo "   ██║  ███╗███████║██╔████╔██║█████╗  ██║   ██║ ╚███╔╝ "
    echo "   ██║   ██║██╔══██║██║╚██╔╝██║██╔══╝  ██║   ██║ ██╔██╗ "
    echo "   ╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗╚██████╔╝██╔╝ ██╗"
    echo "    ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝"
    echo -e "${CYAN}"
    echo "   ████████╗ ██████╗  ██████╗ ██╗     ██╗  ██╗██╗████████╗"
    echo "   ╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██║ ██╔╝██║╚══██╔══╝"
    echo "      ██║   ██║   ██║██║   ██║██║     █████╔╝ ██║   ██║   "
    echo "      ██║   ██║   ██║██║   ██║██║     ██╔═██╗ ██║   ██║   "
    echo "      ██║   ╚██████╔╝╚██████╔╝███████╗██║  ██╗██║   ██║   "
    echo "      ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝   ╚═╝  "
    echo -e "${MAGENTA}"
    echo "   █████╗ ███╗  ██╗ ██████╗ ███╗  ██╗███████╗"
    echo "  ██╔══██╗████╗ ██║██╔═══██╗████╗ ██║██╔════╝"
    echo "  ███████║██╔██╗██║██║   ██║██╔██╗██║███████╗"
    echo "  ██╔══██║██║╚████║██║   ██║██║╚████║╚════██║"
    echo "  ██║  ██║██║ ╚███║╚██████╔╝██║ ╚███║███████║"
    echo "  ╚═╝  ╚═╝╚═╝  ╚══╝ ╚═════╝ ╚═╝  ╚══╝╚══════╝"
    echo -e "${YELLOW}"
    echo "              c0d3d By @non G00nz"
    echo -e "${WHITE}   ======================================================"
    echo -e "   [  Bazzite Gaming OS Toolkit — Powered by rpm-ostree  ]"
    echo -e "   ======================================================${NC}"
    echo ""
}

# ================================================================
#   TOOL DEFINITIONS
#   Format: "display_name|check_command|install_id|install_type"
#   install_type: flatpak | rpm | brew | ujust | manual
# ================================================================

# --- Game Launchers ---
declare -A LAUNCHERS
LAUNCHER_LIST=(
    "Steam|steam|com.valvesoftware.Steam|flatpak"
    "Lutris|lutris|net.lutris.Lutris|flatpak"
    "Heroic Games Launcher|heroic|com.heroicgameslauncher.hgl|flatpak"
    "Bottles|bottles|com.usebottles.bottles|flatpak"
    "Faugus Launcher|faugus-launcher|org.github.faugus.faugus-launcher|flatpak"
    "Minigalaxy|minigalaxy|io.github.sharkwouter.Minigalaxy|flatpak"
    "GameHub|gamehub|com.github.tkashkin.gamehub|flatpak"
    "Pegasus Frontend|pegasus-fe|org.pegasus_frontend.Pegasus|flatpak"
    "RetroArch|retroarch|org.libretro.RetroArch|flatpak"
    "Cartridges|cartridges|page.kramo.Cartridges|flatpak"
)

# --- Gaming Performance Tools ---
PERF_LIST=(
    "MangoHud|mangohud|mangohud|rpm"
    "GameMode|gamemoded|gamemode|rpm"
    "vkBasalt|vkbasalt|vkbasalt|rpm"
    "Gamescope|gamescope|gamescope|rpm"
    "DXVK|dxvk|dxvk|rpm"
    "VKD3D-Proton|vkd3d|vkd3d-proton|rpm"
    "Proton-GE|proton-ge-custom|GE-Proton|ujust"
    "ProtonPlus|protonplus|com.vysp3r.ProtonPlus|flatpak"
    "ProtonUp-Qt|protonup-qt|net.davidotek.pupgui2|flatpak"
    "Mango Juice (MangoHud GUI)|mangojuice|io.github.benjamimgois.mangojuice|flatpak"
    "Lossless Scaling (LSFG)|lsfg-vk|get-lsfg|ujust"
    "CoreCtrl|corectrl|org.corectrl.CoreCtrl|flatpak"
    "LACT (GPU Tool)|lact|install-lact|ujust"
    "Feral GameMode Indicator|gamemode-indicator|gamemode-indicator-git|brew"
    "System76-Scheduler|system76-scheduler|com.system76.Scheduler|rpm"
    "Ananicy-Cpp|ananicy-cpp|ananicy-cpp|rpm"
)

# --- Wine & Compatibility ---
COMPAT_LIST=(
    "Wine|wine|wine|rpm"
    "Winetricks|winetricks|winetricks|rpm"
    "Protontricks|protontricks|com.github.Matoking.protontricks|flatpak"
    "Proton (Steam)|proton|com.valvesoftware.Steam|flatpak"
    "Mono|mono|mono|rpm"
    "DXVK (Wine DX support)|dxvk|dxvk|rpm"
    "VKD3D|vkd3d|vkd3d|rpm"
    "WineZGUI|winezgui|io.github.fastrizwaan.WineZGUI|flatpak"
)

# --- Emulators ---
EMU_LIST=(
    "RetroArch|retroarch|org.libretro.RetroArch|flatpak"
    "RPCS3 (PS3)|rpcs3|net.rpcs3.RPCS3|flatpak"
    "PCSX2 (PS2)|pcsx2|net.pcsx2.PCSX2|flatpak"
    "Dolphin (GC/Wii)|dolphin-emu|org.DolphinEmu.dolphin-emu|flatpak"
    "Yuzu (Switch)|yuzu|org.yuzu_emu.yuzu|flatpak"
    "Ryujinx (Switch)|ryujinx|org.ryujinx.Ryujinx|flatpak"
    "PPSSPP (PSP)|ppsspp|org.ppsspp.PPSSPP|flatpak"
    "DeSmuME (DS)|desmume|org.desmume.DeSmuME|flatpak"
    "mGBA (GBA)|mgba|io.mgba.mGBA|flatpak"
    "MAME|mame|org.mame_emu.mame|flatpak"
    "ScummVM|scummvm|org.scummvm.ScummVM|flatpak"
    "Cemu (Wii U)|cemu|info.cemu.Cemu|flatpak"
    "Xemu (Xbox)|xemu|app.xemu.xemu|flatpak"
    "XENIA (Xbox360)|xenia|app.xenia.xenia|flatpak"
    "Stella (Atari 2600)|stella|io.github.stella_emu.Stella|flatpak"
    "Mednafen|mednafen|mednafen|brew"
    "VICE (C64)|vice|vice|brew"
    "Flycast (Dreamcast)|flycast|org.flycast.Flycast|flatpak"
    "AetherSX2|aethersx2|com.github.aethersx2.AetherSX2|flatpak"
)

# --- GPU Drivers & Info ---
DRIVER_LIST=(
    "Mesa (AMD/Intel OpenGL)|glxinfo|mesa-dri-drivers|rpm"
    "Mesa Vulkan (AMD RADV)|vulkaninfo|mesa-vulkan-drivers|rpm"
    "AMDVLK (AMD Vulkan)|amdvlk|amdvlk|rpm"
    "ROCm OpenCL Runtime|rocminfo|rocm-opencl-runtime|rpm"
    "NVIDIA Open Kernel Module|nvidia-smi|install-nvidia-open|ujust"
    "NVIDIA Container Toolkit|nvidia-container-toolkit|nvidia-container-toolkit|rpm"
    "Intel Media Driver (iHD)|iHD_drv_video.so|intel-media-driver|rpm"
    "VA-API (Video Accel)|vainfo|libva-utils|rpm"
    "VDPAU (Video Decode)|vdpauinfo|vdpauinfo|rpm"
    "OpenCL Tools|clinfo|clinfo|rpm"
    "Vulkan Tools|vulkaninfo|vulkan-tools|rpm"
    "LACT GPU Control|lact|install-lact|ujust"
    "DisplayLink Drivers|displaylink|evdi-kmod|rpm"
    "OpenRazer (Razer Peripherals)|openrazer-daemon|install-openrazer|ujust"
    "OpenTabletDriver|otd|install-opentabletdriver|ujust"
    "Wooting Keyboard Daemon|wootility|wootility|rpm"
    "Xbox Controller Driver (xpadneo)|xpadneo|xpadneo|rpm"
    "Xbox Controller (xone)|xone|xone-dkms|rpm"
    "Bluetooth Stack|bluetoothctl|bluez|rpm"
    "PipeWire (Audio)|pipewire|pipewire|rpm"
    "WirePlumber (Session Manager)|wireplumber|wireplumber|rpm"
    "HDMI CEC (libCEC)|cec-client|libCEC|rpm"
)

# --- Streaming & Recording ---
STREAM_LIST=(
    "OBS Studio|obs|com.obsproject.Studio|flatpak"
    "OBS VkCapture|obs-vkcapture|obs-vkcapture|rpm"
    "Sunshine (Remote Stream)|sunshine|install-sunshine|ujust"
    "Moonlight (Stream Client)|moonlight|com.moonlight_stream.Moonlight|flatpak"
    "Gyroflow Toolbox|gyroflow-toolbox|xyz.gyroflow.GyroflowToolbox|flatpak"
    "StreamFX|streamfx|streamfx|brew"
    "Input Overlay (OBS plugin)|input-overlay|input-overlay|brew"
    "Nvidia NvFBC (Streaming)|nvfbc|nvfbc|rpm"
)

# --- System & Desktop Tools ---
SYSTEM_LIST=(
    "KDE Plasma Desktop|plasmashell|plasma-desktop|rpm"
    "GNOME Desktop|gnome-shell|gnome-shell|rpm"
    "Distrobox|distrobox|distrobox|rpm"
    "DistroShelf (Distrobox GUI)|disrtoshelf|io.github.dvlv.distrobox-gui|flatpak"
    "Flatseal (Flatpak Perms)|flatseal|com.github.tchx84.Flatseal|flatpak"
    "Warehouse (Flatpak Mgr)|warehouse|io.github.flattool.Warehouse|flatpak"
    "Bazaar App Store|bazaar|io.github.kolibrix.Bazaar|flatpak"
    "Bazzite Portal|bazzite-firstboot|bazzite-firstboot|rpm"
    "Topgrade (Universal Updater)|topgrade|topgrade|brew"
    "uupd (Auto Updater)|uupd|uupd|rpm"
    "Kvantum Theme Engine|kvantummanager|kvantum|rpm"
    "Input Remapper|input-remapper-gtk|input-remapper|rpm"
    "Piper (Mouse Config)|piper|org.freedesktop.Piper|flatpak"
    "Solaar (Logitech)|solaar|io.github.pwr_solaar.solaar|flatpak"
    "Discover (Software Center)|plasma-discover|plasma-discover|rpm"
    "GNOME Software|gnome-software|gnome-software|rpm"
    "KDE Partition Manager|partitionmanager|org.kde.partitionmanager|flatpak"
    "GParted|gparted|org.gnome.gparted|flatpak"
    "Timeshift (Backup)|timeshift|timeshift|brew"
    "ClamAV (Antivirus)|clamscan|clamav|rpm"
    "Firejail (Sandbox)|firejail|firejail|rpm"
    "AppArmor|apparmor_status|apparmor|rpm"
    "SELinux Tools|getenforce|selinux-policy|rpm"
    "Waydroid (Android)|waydroid|install-waydroid|ujust"
    "VirtualBox|virtualbox|virtualbox|rpm"
    "QEMU/KVM|qemu-kvm|qemu-kvm|rpm"
    "Podman|podman|podman|rpm"
    "Podman Desktop|podman-desktop|io.podman_desktop.PodmanDesktop|flatpak"
    "SSH Server|sshd|openssh-server|rpm"
    "VNC Server|tigervncserver|tigervnc-server|rpm"
)

# --- Developer Tools ---
DEV_LIST=(
    "VSCode|code|install-vscode|ujust"
    "VSCodium|codium|com.vscodium.codium|flatpak"
    "Neovim|nvim|neovim|rpm"
    "Git|git|git|rpm"
    "GitHub Desktop|github-desktop|io.github.shiftey.Desktop|flatpak"
    "Python 3|python3|python3|rpm"
    "Node.js|node|nodejs|rpm"
    "Rust (rustup)|rustup|rust|rpm"
    "GCC|gcc|gcc|rpm"
    "GDB Debugger|gdb|gdb|rpm"
    "Docker|docker|moby-engine|rpm"
    "Podman|podman|podman|rpm"
    "DaVinci Resolve|resolve|install-resolve|ujust"
    "Zed Editor|zed|dev.zed.Zed|flatpak"
    "Emacs|emacs|org.gnu.emacs|flatpak"
    "JetBrains Toolbox|jetbrains-toolbox|install-jetbrains-toolbox|ujust"
    "Homebrew|brew|homebrew|brew"
    "Flatpak|flatpak|flatpak|rpm"
    "RPM-OSTree|rpm-ostree|rpm-ostree|rpm"
    "Android Studio|android-studio|install-android-studio|ujust"
    "Godot Engine|godot|org.godotengine.Godot|flatpak"
)

# --- Networking Tools ---
NET_LIST=(
    "Firefox|firefox|org.mozilla.firefox|flatpak"
    "Chromium|chromium|org.chromium.Chromium|flatpak"
    "ProtonVPN|protonvpn|com.protonvpn.www|flatpak"
    "Mullvad VPN|mullvad-vpn|net.mullvad.MullvadApp|flatpak"
    "OpenVPN|openvpn|openvpn|rpm"
    "WireGuard|wg|wireguard-tools|rpm"
    "Tor Browser|torbrowser-launcher|com.github.micahflee.torbrowser-launcher|flatpak"
    "NetworkManager TUI|nmtui|NetworkManager-tui|rpm"
    "nmap|nmap|nmap|rpm"
    "Wireshark|wireshark|org.wireshark.Wireshark|flatpak"
    "qBittorrent|qbittorrent|org.qbittorrent.qBittorrent|flatpak"
    "OnionShare|onionshare|org.onionshare.OnionShare|flatpak"
    "Proxychains|proxychains4|proxychains-ng|rpm"
    "Syncthing|syncthing|com.github.zocker_160.SyncThingy|flatpak"
    "KDE Connect|kdeconnect|org.kde.kdeconnect.app|flatpak"
    "GSConnect (GNOME)|gsconnect|com.github.GSConnect|flatpak"
    "SSH Client|ssh|openssh-clients|rpm"
    "curl|curl|curl|rpm"
    "wget|wget|wget|rpm"
)

# --- Multimedia & Content Creation ---
MEDIA_LIST=(
    "VLC Media Player|vlc|org.videolan.VLC|flatpak"
    "Kodi Media Center|kodi|tv.kodi.Kodi|flatpak"
    "Kdenlive (Video Editor)|kdenlive|org.kde.kdenlive|flatpak"
    "Shotcut|shotcut|org.shotcut.Shotcut|flatpak"
    "DaVinci Resolve|resolve|install-resolve|ujust"
    "GIMP|gimp|org.gimp.GIMP|flatpak"
    "Inkscape|inkscape|org.inkscape.Inkscape|flatpak"
    "Blender|blender|org.blender.Blender|flatpak"
    "Krita|krita|org.kde.krita|flatpak"
    "Audacity|audacity|org.audacityteam.Audacity|flatpak"
    "Ardour (DAW)|ardour|org.ardour.Ardour|flatpak"
    "Spotify|spotify|com.spotify.Client|flatpak"
    "Jellyfin (Media Server)|jellyfin|com.github.iwalton3.jellyfin-media-player|flatpak"
    "Plex Media Player|plex|tv.plex.PlexMediaPlayer|flatpak"
    "HandBrake|handbrake|fr.handbrake.ghb|flatpak"
    "FFmpeg|ffmpeg|ffmpeg|rpm"
    "MPV Media Player|mpv|io.mpv.Mpv|flatpak"
)

# --- Game Modding & Utils ---
MOD_LIST=(
    "Protontricks|protontricks|com.github.Matoking.protontricks|flatpak"
    "SteamTinkerLaunch|steamtinkerlaunch|com.valvesoftware.Steam.CompatibilityTool.SteamTinkerLaunch|flatpak"
    "Flips (Patch Tool)|flips|flips|brew"
    "Mod Organizer 2 (via Bottles)|bottles|com.usebottles.bottles|flatpak"
    "GameConqueror (Cheat Engine)|gameconqueror|gameconqueror|rpm"
    "Ludusavi (Game Backup)|ludusavi|com.github.mtkennerly.ludusavi|flatpak"
    "Heroic Game CLI|heroic-games-launcher|install-heroic-game-cli|ujust"
    "Savegame Manager|savegame-manager|io.github.dancs.Savegame-Manager|flatpak"
    "GameScope Session|gamescope|gamescope|rpm"
    "Duperemove (Dedup)|duperemove|duperemove|rpm"
    "BoltRom (Controller FW)|bolt|org.gnome.Bolt|flatpak"
    "Decky Loader (Deck Plugin)|decky|install-decky|ujust"
)

# --- Handheld / HTPC Tools ---
HANDHELD_LIST=(
    "Gamescope Session|gamescope-session|gamescope-session|rpm"
    "HandyGCCS (Handheld Controller)|handygccs|handygccs|rpm"
    "HHD (Handheld Daemon)|hhd|hhd|rpm"
    "Decky Loader|decky|install-decky|ujust"
    "Bazzite HHD UI|hhd-ui|hhd-ui|rpm"
    "ROG Ally Tools|rog-ally|rog-control-center|rpm"
    "Legion Go Tools|legion-go|lenovo-legion-tools|rpm"
    "GPD Win Tools|gpd-win|gpd-win-max2-gnome|rpm"
    "Steam Input|steam-input|com.valvesoftware.Steam|flatpak"
    "Oversteer (Wheel Support)|oversteer|io.github.berarma.Oversteer|flatpak"
    "Joystick Calibration (jstest)|jstest-gtk|jstest-gtk|rpm"
    "AntiMicroX (Gamepad Mapper)|antimicrox|io.github.antimicrox.antimicrox|flatpak"
    "SC-Controller|sc-controller|sc-controller|rpm"
    "Joycond (JoyCon Driver)|joycond|joycond|rpm"
    "DS4Drv (DualShock)|ds4drv|ds4drv|rpm"
    "DualSense (DualSense Edge)|dualsensectl|dualsensectl|rpm"
)

# --- AI & Productivity ---
AI_LIST=(
    "Ollama (Local AI)|ollama|install-ollama|ujust"
    "LibreOffice|libreoffice|org.libreoffice.LibreOffice|flatpak"
    "OnlyOffice|onlyoffice|org.onlyoffice.desktopeditors|flatpak"
    "Obsidian (Notes)|obsidian|md.obsidian.Obsidian|flatpak"
    "Thunderbird (Email)|thunderbird|org.mozilla.Thunderbird|flatpak"
    "Signal (Messenger)|signal-desktop|org.signal.Signal|flatpak"
    "Discord|discord|com.discordapp.Discord|flatpak"
    "Vesktop (Discord Mod)|vesktop|dev.vencord.Vesktop|flatpak"
    "Slack|slack|com.slack.Slack|flatpak"
    "Zoom|zoom|us.zoom.Zoom|flatpak"
    "Bitwarden|bitwarden|com.bitwarden.desktop|flatpak"
    "Nextcloud Desktop|nextcloud|com.nextcloud.desktopclient.nextcloud|flatpak"
    "KDE Akademy AI|kolibri|org.learningequality.Kolibri|flatpak"
)

# ================================================================
#   HELPER FUNCTIONS
# ================================================================

# Check if a binary/command exists on host
is_installed() {
    command -v "$1" &>/dev/null
}

# Check if a Flatpak is installed
is_flatpak_installed() {
    flatpak list --app 2>/dev/null | grep -qi "$1"
}

# Check if RPM package is installed (works on rpm-ostree)
is_rpm_installed() {
    rpm -q "$1" &>/dev/null 2>&1
}

# Check if Homebrew package is installed
is_brew_installed() {
    brew list "$1" &>/dev/null 2>&1
}

# Detect install method
detect_install_method() {
    if command -v rpm-ostree &>/dev/null; then
        echo "rpm-ostree"
    elif command -v dnf &>/dev/null; then
        echo "dnf"
    else
        echo "unknown"
    fi
}

# ================================================================
#   CATEGORY CHECKER
# ================================================================
check_category() {
    local category_name="$1"
    shift
    local -n tool_list_ref=$1

    local installed_count=0
    local missing_count=0

    echo -e "\n${BOLD}${CYAN}╔══════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}${CYAN}║  ${WHITE}$category_name${CYAN}${NC}"
    echo -e "${BOLD}${CYAN}╚══════════════════════════════════════════════════╝${NC}"

    for entry in "${tool_list_ref[@]}"; do
        IFS='|' read -r display_name check_cmd install_id install_type <<< "$entry"

        local found=false

        case "$install_type" in
            flatpak)
                if is_installed "$check_cmd" || is_flatpak_installed "$install_id"; then
                    found=true
                fi
                ;;
            rpm)
                if is_installed "$check_cmd" || is_rpm_installed "$install_id"; then
                    found=true
                fi
                ;;
            brew)
                if is_installed "$check_cmd" || is_brew_installed "$install_id"; then
                    found=true
                fi
                ;;
            ujust)
                if is_installed "$check_cmd"; then
                    found=true
                fi
                ;;
            *)
                if is_installed "$check_cmd"; then
                    found=true
                fi
                ;;
        esac

        if $found; then
            echo -e "  ${GREEN}[✔]${NC} ${WHITE}$display_name${NC} ${GREEN}(installed)${NC} ${CYAN}[$install_type]${NC}"
            ((installed_count++))
        else
            echo -e "  ${RED}[✘]${NC} ${WHITE}$display_name${NC} ${RED}(missing)${NC} ${YELLOW}[$install_type]${NC}"
            ((missing_count++))
            case "$install_type" in
                flatpak) ALL_MISSING_FLATPAK+=("$install_id|$display_name") ;;
                rpm)     ALL_MISSING_RPM+=("$install_id|$display_name") ;;
                brew)    ALL_MISSING_BREW+=("$install_id|$display_name") ;;
                ujust)   ALL_MISSING_UJUST+=("$install_id|$display_name") ;;
            esac
        fi
    done

    echo ""
    echo -e "  ${BOLD}${GREEN}Installed: $installed_count${NC}  |  ${BOLD}${RED}Missing: $missing_count${NC}"
}

# ================================================================
#   INSTALL FUNCTIONS
# ================================================================

install_flatpaks() {
    if [ ${#ALL_MISSING_FLATPAK[@]} -eq 0 ]; then
        echo -e "\n${GREEN}[✔] No missing Flatpak apps.${NC}"; return
    fi
    echo -e "\n${CYAN}[*] Missing Flatpak apps:${NC}"
    for item in "${ALL_MISSING_FLATPAK[@]}"; do
        IFS='|' read -r id name <<< "$item"
        echo -e "  ${RED}→${NC} $name ($id)"
    done
    echo ""
    read -rp "$(echo -e ${YELLOW}"[?] Install all missing Flatpaks now? (y/n): "${NC})" ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        for item in "${ALL_MISSING_FLATPAK[@]}"; do
            IFS='|' read -r id name <<< "$item"
            echo -e "\n${CYAN}[*] Installing Flatpak: $name${NC}"
            if flatpak install -y flathub "$id" 2>/dev/null; then
                echo -e "${GREEN}[✔] $name installed.${NC}"
            else
                echo -e "${RED}[✘] Could not install $name. Try: flatpak install flathub $id${NC}"
            fi
        done
    fi
}

install_rpms() {
    if [ ${#ALL_MISSING_RPM[@]} -eq 0 ]; then
        echo -e "\n${GREEN}[✔] No missing RPM packages.${NC}"; return
    fi
    local method
    method=$(detect_install_method)
    echo -e "\n${CYAN}[*] Missing RPM packages (using $method):${NC}"
    for item in "${ALL_MISSING_RPM[@]}"; do
        IFS='|' read -r id name <<< "$item"
        echo -e "  ${RED}→${NC} $name ($id)"
    done
    echo ""
    echo -e "${YELLOW}[!] On Bazzite, RPM packages are layered via rpm-ostree (requires reboot).${NC}"
    read -rp "$(echo -e ${YELLOW}"[?] Layer missing RPM packages via rpm-ostree? (y/n): "${NC})" ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        local pkg_list=()
        for item in "${ALL_MISSING_RPM[@]}"; do
            IFS='|' read -r id name <<< "$item"
            pkg_list+=("$id")
        done
        echo -e "\n${CYAN}[*] Running: rpm-ostree install ${pkg_list[*]}${NC}"
        rpm-ostree install "${pkg_list[@]}"
        echo -e "\n${YELLOW}[!] Reboot required to apply rpm-ostree changes.${NC}"
        read -rp "$(echo -e ${CYAN}"[?] Reboot now? (y/n): "${NC})" rb
        [[ "$rb" =~ ^[Yy]$ ]] && systemctl reboot
    fi
}

install_brew_pkgs() {
    if [ ${#ALL_MISSING_BREW[@]} -eq 0 ]; then
        echo -e "\n${GREEN}[✔] No missing Homebrew packages.${NC}"; return
    fi
    if ! command -v brew &>/dev/null; then
        echo -e "${RED}[✘] Homebrew is not installed. Install it first:${NC}"
        echo -e "${CYAN}  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"${NC}"
        return
    fi
    echo -e "\n${CYAN}[*] Missing Homebrew packages:${NC}"
    for item in "${ALL_MISSING_BREW[@]}"; do
        IFS='|' read -r id name <<< "$item"
        echo -e "  ${RED}→${NC} $name ($id)"
    done
    echo ""
    read -rp "$(echo -e ${YELLOW}"[?] Install missing Homebrew packages? (y/n): "${NC})" ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        for item in "${ALL_MISSING_BREW[@]}"; do
            IFS='|' read -r id name <<< "$item"
            echo -e "\n${CYAN}[*] brew install $id${NC}"
            brew install "$id" && echo -e "${GREEN}[✔] $name installed.${NC}" || \
                echo -e "${RED}[✘] Could not install $name.${NC}"
        done
    fi
}

install_ujust_pkgs() {
    if [ ${#ALL_MISSING_UJUST[@]} -eq 0 ]; then
        echo -e "\n${GREEN}[✔] No missing ujust tools.${NC}"; return
    fi
    echo -e "\n${CYAN}[*] Missing ujust tools (Bazzite scripts):${NC}"
    for item in "${ALL_MISSING_UJUST[@]}"; do
        IFS='|' read -r id name <<< "$item"
        echo -e "  ${RED}→${NC} $name  (ujust $id)"
    done
    echo ""
    read -rp "$(echo -e ${YELLOW}"[?] Run ujust install commands for missing tools? (y/n): "${NC})" ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        for item in "${ALL_MISSING_UJUST[@]}"; do
            IFS='|' read -r id name <<< "$item"
            echo -e "\n${CYAN}[*] Running: ujust $id${NC}"
            if command -v ujust &>/dev/null; then
                ujust "$id" && echo -e "${GREEN}[✔] $name done.${NC}" || \
                    echo -e "${RED}[✘] ujust $id failed. Run manually.${NC}"
            else
                echo -e "${RED}[✘] ujust not found. Are you on Bazzite?${NC}"
            fi
        done
    fi
}

install_all_missing() {
    echo -e "\n${BOLD}${YELLOW}============ INSTALL ALL MISSING TOOLS ============${NC}"
    install_flatpaks
    install_rpms
    install_brew_pkgs
    install_ujust_pkgs
    echo -e "\n${GREEN}[✔] Install process complete.${NC}"
}

# ================================================================
#   SINGLE CATEGORY SCAN + OPTIONAL INSTALL
# ================================================================
scan_and_offer() {
    local name="$1"
    local listref="$2"

    ALL_MISSING_FLATPAK=()
    ALL_MISSING_RPM=()
    ALL_MISSING_BREW=()
    ALL_MISSING_UJUST=()

    check_category "$name" "$listref"

    local total_missing=$(( ${#ALL_MISSING_FLATPAK[@]} + ${#ALL_MISSING_RPM[@]} + ${#ALL_MISSING_BREW[@]} + ${#ALL_MISSING_UJUST[@]} ))

    if [ "$total_missing" -gt 0 ]; then
        echo ""
        read -rp "$(echo -e ${CYAN}"[?] Install $total_missing missing tools in this category? (y/n): "${NC})" ans
        if [[ "$ans" =~ ^[Yy]$ ]]; then
            install_all_missing
        fi
    else
        echo -e "\n${GREEN}[✔] All tools in this category are installed!${NC}"
    fi
    read -rp "$(echo -e ${WHITE}"  Press [Enter] to return to menu..."${NC})"
}

# ================================================================
#   FULL SYSTEM SCAN
# ================================================================
full_scan() {
    ALL_MISSING_FLATPAK=()
    ALL_MISSING_RPM=()
    ALL_MISSING_BREW=()
    ALL_MISSING_UJUST=()

    check_category "Game Launchers"              LAUNCHER_LIST
    check_category "Gaming Performance Tools"    PERF_LIST
    check_category "Wine & Compatibility"        COMPAT_LIST
    check_category "Emulators"                   EMU_LIST
    check_category "GPU Drivers & Hardware"      DRIVER_LIST
    check_category "Streaming & Recording"       STREAM_LIST
    check_category "System & Desktop Tools"      SYSTEM_LIST
    check_category "Developer Tools"             DEV_LIST
    check_category "Networking & VPN"            NET_LIST
    check_category "Multimedia & Content"        MEDIA_LIST
    check_category "Game Modding & Utils"        MOD_LIST
    check_category "Handheld & HTPC Tools"       HANDHELD_LIST
    check_category "AI & Productivity"           AI_LIST

    local total=$(( ${#ALL_MISSING_FLATPAK[@]} + ${#ALL_MISSING_RPM[@]} + ${#ALL_MISSING_BREW[@]} + ${#ALL_MISSING_UJUST[@]} ))
    echo ""
    echo -e "${BOLD}${YELLOW}  ╔══════════════════════════════════════╗"
    echo -e "  ║  TOTAL MISSING TOOLS: $total"
    echo -e "  ╚══════════════════════════════════════╝${NC}"
    echo -e "  ${CYAN}Flatpak missing : ${#ALL_MISSING_FLATPAK[@]}${NC}"
    echo -e "  ${CYAN}RPM missing     : ${#ALL_MISSING_RPM[@]}${NC}"
    echo -e "  ${CYAN}Brew missing    : ${#ALL_MISSING_BREW[@]}${NC}"
    echo -e "  ${CYAN}ujust missing   : ${#ALL_MISSING_UJUST[@]}${NC}"
    echo ""
    if [ "$total" -gt 0 ]; then
        read -rp "$(echo -e ${YELLOW}"[?] Install ALL missing tools now? (y/n): "${NC})" ans
        [[ "$ans" =~ ^[Yy]$ ]] && install_all_missing
    fi
    read -rp "$(echo -e ${WHITE}"  Press [Enter] to return to menu..."${NC})"
}

# ================================================================
#   SYSTEM UPDATE
# ================================================================
system_update() {
    echo -e "\n${CYAN}[*] Running Bazzite full system update (topgrade)...${NC}"
    if command -v topgrade &>/dev/null; then
        topgrade
    else
        echo -e "${YELLOW}[!] Topgrade not found. Falling back to ujust update...${NC}"
        if command -v ujust &>/dev/null; then
            ujust update
        else
            echo -e "${CYAN}[*] Running rpm-ostree upgrade...${NC}"
            rpm-ostree upgrade
            echo -e "${CYAN}[*] Updating Flatpaks...${NC}"
            flatpak update -y
        fi
    fi
    echo -e "${GREEN}[✔] Update complete!${NC}"
    read -rp "$(echo -e ${WHITE}"  Press [Enter] to continue..."${NC})"
}

# ================================================================
#   DRIVER REBASE HELPER
# ================================================================
driver_rebase() {
    echo -e "\n${BOLD}${CYAN}══════════ GPU Driver Rebase Helper ══════════${NC}"
    echo -e "${WHITE}  Bazzite GPU variants:${NC}"
    echo -e "  ${GREEN}[1]${NC} Standard (AMD/Intel Mesa)      → ghcr.io/ublue-os/bazzite:stable"
    echo -e "  ${GREEN}[2]${NC} NVIDIA Open Kernel             → ghcr.io/ublue-os/bazzite-nvidia-open:stable"
    echo -e "  ${GREEN}[3]${NC} NVIDIA Proprietary             → ghcr.io/ublue-os/bazzite-nvidia:stable"
    echo -e "  ${GREEN}[4]${NC} Deck / HTPC (AMD)              → ghcr.io/ublue-os/bazzite-deck:stable"
    echo -e "  ${GREEN}[5]${NC} Deck / HTPC + NVIDIA           → ghcr.io/ublue-os/bazzite-deck-nvidia:stable"
    echo -e "  ${GREEN}[0]${NC} Cancel"
    echo ""
    read -rp "$(echo -e ${YELLOW}"[?] Choose a variant to rebase to: "${NC})" variant_choice

    local rebase_target=""
    case "$variant_choice" in
        1) rebase_target="ostree-image-signed:docker://ghcr.io/ublue-os/bazzite:stable" ;;
        2) rebase_target="ostree-image-signed:docker://ghcr.io/ublue-os/bazzite-nvidia-open:stable" ;;
        3) rebase_target="ostree-image-signed:docker://ghcr.io/ublue-os/bazzite-nvidia:stable" ;;
        4) rebase_target="ostree-image-signed:docker://ghcr.io/ublue-os/bazzite-deck:stable" ;;
        5) rebase_target="ostree-image-signed:docker://ghcr.io/ublue-os/bazzite-deck-nvidia:stable" ;;
        0) return ;;
        *) echo -e "${RED}[!] Invalid choice.${NC}"; return ;;
    esac

    echo -e "\n${YELLOW}[!] This will rebase your system to:${NC}"
    echo -e "    ${CYAN}$rebase_target${NC}"
    echo -e "${RED}[!] A reboot is required after rebasing.${NC}"
    read -rp "$(echo -e ${YELLOW}"[?] Proceed with rebase? (y/n): "${NC})" confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        rpm-ostree rebase "$rebase_target"
        echo -e "${YELLOW}[!] Rebase queued. Reboot to apply.${NC}"
        read -rp "$(echo -e ${CYAN}"[?] Reboot now? (y/n): "${NC})" rb
        [[ "$rb" =~ ^[Yy]$ ]] && systemctl reboot
    fi
    read -rp "$(echo -e ${WHITE}"  Press [Enter] to continue..."${NC})"
}

# ================================================================
#   SYSTEM INFO
# ================================================================
system_info() {
    echo -e "\n${CYAN}╔══════════════════════════════════════════════════╗"
    echo -e "║           Bazzite System Information             ║"
    echo -e "╚══════════════════════════════════════════════════╝${NC}"

    local gpu_info
    gpu_info=$(lspci 2>/dev/null | grep -i 'vga\|3d\|display' | head -3)

    echo -e "${WHITE}Hostname    :${NC} $(hostname)"
    echo -e "${WHITE}OS Image    :${NC} $(rpm-ostree status 2>/dev/null | grep '●' | awk '{print $2}' | head -1 || echo 'Bazzite (Fedora Atomic)')"
    echo -e "${WHITE}OS Version  :${NC} $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')"
    echo -e "${WHITE}Kernel      :${NC} $(uname -r)"
    echo -e "${WHITE}Desktop     :${NC} ${XDG_CURRENT_DESKTOP:-Unknown}"
    echo -e "${WHITE}Architecture:${NC} $(uname -m)"
    echo -e "${WHITE}CPU         :${NC} $(grep -m1 'model name' /proc/cpuinfo | cut -d: -f2 | xargs)"
    echo -e "${WHITE}GPU(s)      :${NC}"
    echo "$gpu_info" | while read -r line; do
        echo -e "              $line"
    done
    echo -e "${WHITE}IP Address  :${NC} $(hostname -I | awk '{print $1}')"
    echo -e "${WHITE}User        :${NC} $(whoami)"
    echo -e "${WHITE}Uptime      :${NC} $(uptime -p)"
    echo -e "${WHITE}Memory      :${NC} $(free -h | awk '/^Mem:/ {print $3 " used / " $2 " total"}')"
    echo -e "${WHITE}Disk (/)    :${NC} $(df -h / | awk 'NR==2 {print $3 " used / " $2 " total (" $5 " used)"}')"
    echo -e "${WHITE}SELinux     :${NC} $(getenforce 2>/dev/null || echo 'N/A')"

    # Detect GPU driver in use
    echo -e "${WHITE}OpenGL GPU  :${NC} $(glxinfo 2>/dev/null | grep 'OpenGL renderer' | cut -d: -f2 | xargs || echo 'Run: glxinfo')"
    echo -e "${WHITE}Vulkan GPU  :${NC} $(vulkaninfo 2>/dev/null | grep 'deviceName' | head -1 | awk -F= '{print $2}' | xargs || echo 'Run: vulkaninfo')"
    echo -e "${WHITE}NVIDIA SMI  :${NC} $(nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null || echo 'No NVIDIA GPU or driver')"
    echo -e "${WHITE}ROCm        :${NC} $(rocminfo 2>/dev/null | grep 'Marketing Name' | head -1 | awk -F: '{print $2}' | xargs || echo 'ROCm not available')"
    echo ""
    read -rp "$(echo -e ${WHITE}"  Press [Enter] to continue..."${NC})"
}

# ================================================================
#   LAUNCH TOOL
# ================================================================
launch_tool() {
    read -rp "$(echo -e ${CYAN}"[?] Enter tool/command to launch: "${NC})" tool_name
    if is_installed "$tool_name"; then
        echo -e "${GREEN}[*] Launching: $tool_name${NC}"
        nohup "$tool_name" &>/dev/null &
        echo -e "${GREEN}[✔] Launched in background.${NC}"
    else
        echo -e "${RED}[✘] '$tool_name' not found in PATH.${NC}"
        echo -e "${YELLOW}[!] Try launching via Flatpak: flatpak run <app-id>${NC}"
    fi
    read -rp "$(echo -e ${WHITE}"  Press [Enter] to continue..."${NC})"
}

# ================================================================
#   UJUST INTERACTIVE MENU
# ================================================================
ujust_menu() {
    echo -e "\n${CYAN}[*] Launching ujust interactive chooser...${NC}"
    if command -v ujust &>/dev/null; then
        ujust --choose
    else
        echo -e "${RED}[✘] ujust not found. This script is designed for Bazzite OS.${NC}"
    fi
    read -rp "$(echo -e ${WHITE}"  Press [Enter] to continue..."${NC})"
}

# ================================================================
#   ROLLBACK HELPER
# ================================================================
rollback_menu() {
    echo -e "\n${BOLD}${YELLOW}══════════ Rollback / Deployment Manager ══════════${NC}"
    echo -e "${CYAN}[*] Current deployments:${NC}"
    rpm-ostree status
    echo ""
    echo -e "  ${GREEN}[1]${NC} Rollback to previous deployment"
    echo -e "  ${GREEN}[2]${NC} Pin current deployment"
    echo -e "  ${GREEN}[3]${NC} List all available deployments"
    echo -e "  ${GREEN}[0]${NC} Back to menu"
    echo ""
    read -rp "$(echo -e ${YELLOW}"[?] Choose: "${NC})" rb_choice
    case "$rb_choice" in
        1)
            echo -e "${YELLOW}[*] Rolling back...${NC}"
            rpm-ostree rollback
            read -rp "$(echo -e ${CYAN}"[?] Reboot to apply rollback? (y/n): "${NC})" rb
            [[ "$rb" =~ ^[Yy]$ ]] && systemctl reboot ;;
        2)
            echo -e "${YELLOW}[*] Pinning current deployment...${NC}"
            rpm-ostree pin ;;
        3)
            rpm-ostree status --verbose ;;
        0) return ;;
        *) echo -e "${RED}[!] Invalid.${NC}" ;;
    esac
    read -rp "$(echo -e ${WHITE}"  Press [Enter] to continue..."${NC})"
}

# ================================================================
#   BAZZITE PORTAL LAUNCHER
# ================================================================
bazzite_portal() {
    echo -e "\n${CYAN}[*] Launching Bazzite Portal...${NC}"
    if is_installed "bazzite-firstboot"; then
        bazzite-firstboot &
        echo -e "${GREEN}[✔] Bazzite Portal launched.${NC}"
    elif is_installed "ujust"; then
        echo -e "${YELLOW}[!] Bazzite Portal binary not found. Opening ujust chooser instead...${NC}"
        ujust --choose
    else
        echo -e "${RED}[✘] Neither Bazzite Portal nor ujust found.${NC}"
    fi
    read -rp "$(echo -e ${WHITE}"  Press [Enter] to continue..."${NC})"
}

# ================================================================
#   INSTALL GAMING ESSENTIALS (QUICK SETUP)
# ================================================================
quick_gaming_setup() {
    echo -e "\n${BOLD}${CYAN}══════════ Quick Gaming Essentials Setup ══════════${NC}"
    echo -e "${WHITE}This will install the core gaming stack:${NC}"
    echo -e "  ${CYAN}→${NC} Steam, Lutris, Heroic, Bottles"
    echo -e "  ${CYAN}→${NC} MangoHud, GameMode, vkBasalt, Gamescope"
    echo -e "  ${CYAN}→${NC} Protontricks, ProtonPlus, ProtonUp-Qt"
    echo -e "  ${CYAN}→${NC} OBS Studio, CoreCtrl, Flatseal"
    echo ""
    read -rp "$(echo -e ${YELLOW}"[?] Proceed with quick gaming setup? (y/n): "${NC})" ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        echo -e "\n${CYAN}[*] Installing essential Flatpaks...${NC}"
        flatpak install -y flathub \
            com.valvesoftware.Steam \
            net.lutris.Lutris \
            com.heroicgameslauncher.hgl \
            com.usebottles.bottles \
            com.github.Matoking.protontricks \
            net.davidotek.pupgui2 \
            com.vysp3r.ProtonPlus \
            io.github.benjamimgois.mangojuice \
            com.obsproject.Studio \
            org.corectrl.CoreCtrl \
            com.github.tchx84.Flatseal \
            io.github.flattool.Warehouse \
            net.davidotek.pupgui2

        echo -e "\n${CYAN}[*] Installing RPM performance packages via rpm-ostree...${NC}"
        rpm-ostree install \
            mangohud \
            gamemode \
            vkbasalt \
            gamescope \
            dxvk \
            winetricks

        echo -e "\n${YELLOW}[!] RPM packages require a reboot to activate.${NC}"
        echo -e "${GREEN}[✔] Quick gaming setup complete!${NC}"
        read -rp "$(echo -e ${CYAN}"[?] Reboot now to apply changes? (y/n): "${NC})" rb
        [[ "$rb" =~ ^[Yy]$ ]] && systemctl reboot
    fi
    read -rp "$(echo -e ${WHITE}"  Press [Enter] to continue..."${NC})"
}

# ================================================================
#   MAIN MENU
# ================================================================
main_menu() {
    while true; do
        print_banner
        echo -e "  ${WHITE}╔══════════════════════════════════════════════════╗${NC}"
        echo -e "  ${WHITE}║              MAIN MENU                          ║${NC}"
        echo -e "  ${WHITE}╚══════════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${BOLD}${YELLOW}[ SCAN TOOLS ]${NC}"
        echo -e "  ${CYAN}[1]${NC}  Full System Scan (All Categories)"
        echo -e "  ${CYAN}[2]${NC}  Game Launchers"
        echo -e "  ${CYAN}[3]${NC}  Gaming Performance Tools"
        echo -e "  ${CYAN}[4]${NC}  Wine & Compatibility Layers"
        echo -e "  ${CYAN}[5]${NC}  Emulators"
        echo -e "  ${CYAN}[6]${NC}  GPU Drivers & Hardware"
        echo -e "  ${CYAN}[7]${NC}  Streaming & Recording"
        echo -e "  ${CYAN}[8]${NC}  System & Desktop Tools"
        echo -e "  ${CYAN}[9]${NC}  Developer Tools"
        echo -e "  ${CYAN}[10]${NC} Networking & VPN"
        echo -e "  ${CYAN}[11]${NC} Multimedia & Content Creation"
        echo -e "  ${CYAN}[12]${NC} Game Modding & Utilities"
        echo -e "  ${CYAN}[13]${NC} Handheld & HTPC Tools"
        echo -e "  ${CYAN}[14]${NC} AI & Productivity"
        echo ""
        echo -e "  ${BOLD}${YELLOW}[ INSTALL & MANAGE ]${NC}"
        echo -e "  ${CYAN}[15]${NC} Quick Gaming Essentials Setup"
        echo -e "  ${CYAN}[16]${NC} GPU Driver Rebase Helper"
        echo -e "  ${CYAN}[17]${NC} System Update (topgrade / ujust update)"
        echo -e "  ${CYAN}[18]${NC} Rollback / Deployment Manager"
        echo -e "  ${CYAN}[19]${NC} Bazzite Portal (ujust GUI)"
        echo -e "  ${CYAN}[20]${NC} ujust Interactive Chooser"
        echo ""
        echo -e "  ${BOLD}${YELLOW}[ UTILITIES ]${NC}"
        echo -e "  ${CYAN}[21]${NC} Launch a Tool"
        echo -e "  ${CYAN}[22]${NC} System Information"
        echo -e "  ${RED}[0]${NC}  Exit"
        echo ""
        read -rp "$(echo -e ${YELLOW}"  [>] Select an option: "${NC})" opt

        # Reset missing arrays each time
        ALL_MISSING_FLATPAK=()
        ALL_MISSING_RPM=()
        ALL_MISSING_BREW=()
        ALL_MISSING_UJUST=()

        case "$opt" in
            1)  full_scan ;;
            2)  scan_and_offer "Game Launchers"             LAUNCHER_LIST ;;
            3)  scan_and_offer "Gaming Performance Tools"   PERF_LIST ;;
            4)  scan_and_offer "Wine & Compatibility"       COMPAT_LIST ;;
            5)  scan_and_offer "Emulators"                  EMU_LIST ;;
            6)  scan_and_offer "GPU Drivers & Hardware"     DRIVER_LIST ;;
            7)  scan_and_offer "Streaming & Recording"      STREAM_LIST ;;
            8)  scan_and_offer "System & Desktop Tools"     SYSTEM_LIST ;;
            9)  scan_and_offer "Developer Tools"            DEV_LIST ;;
            10) scan_and_offer "Networking & VPN"           NET_LIST ;;
            11) scan_and_offer "Multimedia & Content"       MEDIA_LIST ;;
            12) scan_and_offer "Game Modding & Utils"       MOD_LIST ;;
            13) scan_and_offer "Handheld & HTPC Tools"      HANDHELD_LIST ;;
            14) scan_and_offer "AI & Productivity"          AI_LIST ;;
            15) quick_gaming_setup ;;
            16) driver_rebase ;;
            17) system_update ;;
            18) rollback_menu ;;
            19) bazzite_portal ;;
            20) ujust_menu ;;
            21) launch_tool ;;
            22) system_info ;;
            0)
                echo -e "\n${RED}  [!] Exiting Anon's Gameux Toolkit. Game on.${NC}\n"
                exit 0 ;;
            *)
                echo -e "${RED}  [!] Invalid option.${NC}"
                sleep 1 ;;
        esac
    done
}

# ================================================================
#   BAZZITE CHECK
# ================================================================
if ! command -v rpm-ostree &>/dev/null && ! command -v flatpak &>/dev/null; then
    echo -e "${YELLOW}[!] Warning: rpm-ostree and flatpak not detected."
    echo -e "    This toolkit is optimized for Bazzite OS."
    echo -e "    Some features may not work on other distros.${NC}"
    sleep 2
fi

if [[ $EUID -ne 0 ]]; then
    echo -e "${YELLOW}[!] Not running as root. Some install operations may require sudo/pkexec.${NC}"
    sleep 1
fi

# ================================================================
#   ENTRY POINT
# ================================================================
main_menu

