if [ (tty) = "/dev/tty1" ]
    systemctl --user import-environment PATH
    set -x XDG_CURRENT_DESKTOP sway:wlroots
    exec sway
end
