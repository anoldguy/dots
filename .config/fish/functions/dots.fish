function dots --wraps git --description 'Works with dotfiles'
    git --git-dir=$HOME/.dots/ --work-tree=$HOME -c status.showUntrackedFiles=no -c core.excludesFile=$HOME/.config/dots.gitignore $argv
end

function dots_setup
    git clone https://github.com/anoldguy/dots.git --bare $HOME/.dots
end

function dots_apply
    dots fetch --all
    dots reset --hard
end
