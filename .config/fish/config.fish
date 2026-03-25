if [ (tty) = "/dev/tty1" ]
    systemctl --user import-environment PATH
    set -x XDG_CURRENT_DESKTOP Hyprland
    #exec Hyprland
    exec start-hyprland
end
