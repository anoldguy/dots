function dots --wraps git --description 'Works with dotfiles'
    /usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME $argv
end
