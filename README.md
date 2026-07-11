# shibaniri-dots
My Shiba dots
Pacstall > Niri 


# required downloads


sudo apt install pamixer pulseaudio-utils ripgrep playerctl input-remapper plasma-browser-integration libxkbcommon-x11-dev libfuse2 libxcb-util-dev libxcb-cursor-dev

sudo apt install alacritty swaybg xdg-desktop-portal-gtk gnome-keyring mako-notifier font-manager thunar mousepad mpv polkit-kde-agent-1 gtklock swayidle

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

then to show in gnome login manager

sudo nano /etc/default/grub

add nvidia-drm.modeset=1 to grub_cmdline_linux_default

# Aseprite
Aseprite - https://github.com/aseprite/aseprite/blob/main/INSTALL.md

Easy steps:

1. Clone Git to a folder in $HOME.
2. Download the skia dependency, copy it to ~/aseprite-build/aseprite/.deps (create .deps folder)
3. Run build.sh from terminal (e.g. ~/aseprite-build/aseprite/build.sh)

# Notes
plasma-browser-integration - follow steps to change about:preferences in firefox (https://www.reddit.com/r/kde/comments/1te6lk8/the_best_method_to_fix_broken_mpris_thumbnails/)

set up swayidle on startup - https://niri-wm.github.io/niri/Example-systemd-Setup.html

# symlinking
If we want to run an app easily from terminal:

sudo ln -s ~/aseprite-builder/aseprite/build/bin/aseprite /usr/local/bin (aseprite as an example)

sudo ln -sf ~/eww/target/release/eww /usr/local/bin/eww (eww as an example)
