# shibaniri-dots
My Shiba dots
Pacstall > Niri 


# required downloads


sudo apt install pamixer pulseaudio-utils ripgrep playerctl input-remapper plasma-browser-integration libxkbcommon-x11-dev libfuse2 libxcb-util-dev libxcb-cursor-dev libnotify-bin lm-sensors

sudo apt install alacritty swaybg xdg-desktop-portal-gtk gnome-keyring mako-notifier font-manager thunar mousepad mpv polkit-kde-agent-1 gtklock swayidle

sudo apt install fastfetch cava feh

sudo apt install build-essential libfftw3-dev libasound2-dev libpulse-dev libtool automake libiniparser-dev libsdl2-2.0-0 libsdl2-dev libpipewire-0.3-dev libjack-jackd2-dev pkgconf

# Xwayland satellite 
1. git clone https://github.com/Supreeeme/xwayland-satellite
2. cargo build
3. then, create a symlink to /usr/local/bin from ~/FOLDER_XWAYLAND_WAS_CLONED_TO/xwayland-satellite/target/debug/xwayland-satellite



# EWW

Eww bar - https://github.com/elkowar/eww

sudo apt install libgtk-3-dev libpango1.0-dev libdbusmenu-gtk3-dev libcairo2-dev libglib2.0-dev build-essential libc6-dev libgtk-layer-shell-dev

# NVIDIA GPU 
1. https://wiki.debian.org/NvidiaGraphicsDrivers#GPU_identification
2. Add to /etc/apt/sources.list/
3. deb http://deb.debian.org/debian/ trixie main contrib non-free non-free-firmware
4. deb http://security.debian.org/debian-security/ trixie-security contrib non-free main non-free-firmware
5. deb http://deb.debian.org/debian/ trixie-updates non-free-firmware non-free contrib main
6. then # apt install nvidia-kernel-dkms nvidia-driver and # apt install linux-headers-generic
7. then, must add "options nvidia-drm modeset=1" to /etc/modeprobe.d/nvidia-kms.conf
   
then, to enable wakeup from sleep:
1. sudo systemctl enable nvidia-suspend.service && sudo systemctl enable nvidia-hibernate.service && sudo systemctl enable nvidia-resume.service
2. sudo nano /etc/modprobe.d/nvidia-power-management.conf
3. Add "options nvidia NVreg_PreserveVideoMemoryAllocations=1", then save and exit

then to show in gnome login manager

# Aseprite
Aseprite - https://github.com/aseprite/aseprite/blob/main/INSTALL.md

Easy steps:

1. Clone Git to a folder in $HOME.
2. Download the skia dependency, copy it to ~/aseprite-build/aseprite/.deps (create .deps folder)
3. Run build.sh from terminal (e.g. ~/aseprite-build/aseprite/build.sh)

# Cava

Don't need

sudo apt install build-essential automake libtool git libfftw3-dev libncursesw5-dev libasound2-dev libpulse-dev

sudo apt install build-essential libfftw3-dev libasound2-dev libpulse-dev libtool automake libiniparser-dev libsdl2-2.0-0 libsdl2-dev libpipewire-0.3-dev libjack-jackd2-dev pkgconf

# Notes
plasma-browser-integration - follow steps to change about:preferences in firefox (https://www.reddit.com/r/kde/comments/1te6lk8/the_best_method_to_fix_broken_mpris_thumbnails/)

set up swayidle on startup - https://niri-wm.github.io/niri/Example-systemd-Setup.html

Mousepad - add yuck styling. sudo nano /usr/share/gtksourceview-4/language-specs/commonlisp.lang

Add *.yuck to "globs"



# symlinking
If we want to run an app easily from terminal:

sudo ln -s ~/aseprite-builder/aseprite/build/bin/aseprite /usr/local/bin (aseprite as an example)

sudo ln -sf ~/eww/target/release/eww /usr/local/bin/eww (eww as an example)
