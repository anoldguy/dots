# Ensure homebrew exists
set brewcmds (
    path filter \
        $HOME/.homebrew/bin/brew \
        $HOME/.linuxbrew/bin/brew \
        /opt/homebrew/bin/brew \
        /usr/local/bin/brew
    )
test (count $brewcmds) -gt 0 || return 1

# Remove cached files older than one day (throttled to once per day).
set -l cache_cleanup_marker $__fish_cache_dir/.last_cleanup
if not test -f $cache_cleanup_marker; or test -n (find $cache_cleanup_marker -mtime +1 2>/dev/null)
    find $__fish_cache_dir -maxdepth 1 -type f -mtime +1 -delete &>/dev/null
    touch $cache_cleanup_marker
end

# Init brew
cachecmd $brewcmds[1] shellenv | source

# Add homebrew completions
if test -e $HOMEBREW_PREFIX/share/fish/completions
    set -a fish_complete_path $HOMEBREW_PREFIX/share/fish/completions
end


# Add keg-only apps
for app in ruby curl sqlite
    if test -d "$HOMEBREW_PREFIX/opt/$app/bin"
        fish_add_path "$HOMEBREW_PREFIX/opt/$app/bin"
        set MANPATH "$HOMEBREW_PREFIX/opt/$app/share/man" $MANPATH
    end
end

# Other homebrew vars.
set -gx HOMEBREW_NO_ANALYTICS 1

# Add more man page paths.
for manpath in (path filter $__fish_data_dir/man /usr/local/share/man /usr/share/man)
    set -a MANPATH $manpath
end

# Allow subdirs for functions and completions.
set fish_function_path (path resolve $__fish_config_dir/functions/*/) $fish_function_path
set fish_complete_path (path resolve $__fish_config_dir/completions/*/) $fish_complete_path

# Set editor variables.
set -gx PAGER less
set -gx EDITOR vim

# Add bits to path; once.
fish_add_path /usr/local/sbin $HOME/go/bin /opt/homebrew/bin $HOME/.cargo/bin $HOME/.local/bin $HOME/bin

# Source private data like credentials or work-related stuff
if test -e $HOME/.private.config.fish
    source $HOME/.private.config.fish
end
