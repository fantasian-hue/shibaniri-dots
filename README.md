# shibaniri-dots
My Shiba dots
Pacstall > Niri 


# required downloads


sudo apt install pamixer pulseaudio-utils ripgrep playerctl input-remapper plasma-browser-integration libxkbcommon-x11-dev libfuse2

sudo apt install alacritty swaybg xdg-desktop-portal-gtk gnome-keyring mako-notifier font-manager thunar mousepad mpv polkit-kde-agent-1 gtklock swayidle

Xwayland satellite cargo https://github.com/Supreeeme/xwayland-satellite
cargo install --path /home/quokka/xwayland-satellite

Aseprite (compiled via docker) - https://www.reddit.com/r/aseprite/comments/ms1ef4/easily_compile_aseprite_for_linux/ and https://github.com/nilsve/docker-aseprite-linux

# EWW

Eww bar - https://github.com/elkowar/eww

sudo apt install libgtk-3-dev libpango1.0-dev libdbusmenu-gtk3-dev libcairo2-dev libglib2.0-dev build-essential libc6-dev libgtk-layer-shell-dev

Set eww as path:
sudo ln -sf ~/eww/target/release/eww /usr/local/bin/eww

# NVIDIA GPU 
https://wiki.debian.org/NvidiaGraphicsDrivers#GPU_identification

Add to /etc/apt/sources.list/

deb http://deb.debian.org/debian/ trixie main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security/ trixie-security contrib non-free main non-free-firmware

deb http://deb.debian.org/debian/ trixie-updates non-free-firmware non-free contrib main

then # apt install nvidia-kernel-dkms nvidia-driver and # apt install linux-headers-generic

then, must add "options nvidia-drm modeset=1" to /etc/modeprobe.d/nvidia-kms.conf

then to show in gnome login manager

sudo nano /etc/default/grub

add nvidia-drm.modeset=1 to grub_cmdline_linux_default


# Notes
plasma-browser-integration - then follow steps to change about:preferences in firefox (https://www.reddit.com/r/kde/comments/1te6lk8/the_best_method_to_fix_broken_mpris_thumbnails/)

set up swayidle - https://niri-wm.github.io/niri/Example-systemd-Setup.html
