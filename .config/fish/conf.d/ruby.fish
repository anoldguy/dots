if status --is-interactive
    command -s rbenv > /dev/null; or return 1

    set -x RBENV_ROOT "$HOME/.rbenv"
    set -x PATH $RBENV_ROOT/shims $PATH
    set -x RBENV_SHELL fish

    if test ! -d "$RBENV_ROOT/shims"; or test ! -d "$RBENV_ROOT/versions"
        command mkdir -p $RBENV_ROOT/{shims,versions}
    end
end
