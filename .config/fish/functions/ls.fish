function ls --wraps=lsd --description 'alias ls lsd'
  if type -q lsd
      lsd --group-directories-first $argv
  else
      command ls $argv
  end
end
