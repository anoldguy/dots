# Gate ruby stuff on presence of rbenv
if status --is-interactive; and which rbenv >/dev/null
    cachecmd rbenv init - | source

    set --export BUNDLE_PATH ".bundle/gems"
    set --export BUNDLE_BIN ".bundle/bin"
    set --export BUNDLER_EDITOR "code --add"
    set --export UNSPRUNG 1
end
