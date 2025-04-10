function dots --wraps git --description 'Works with dotfiles'
    /usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME -c status.showUntrackedFiles=no -c core.excludesFile=$HOME/.config/dots.gitignore $argv
end
