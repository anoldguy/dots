function dt --description "DT a host for a time in minutes"
  argparse 'd/duration=' 'h/host=' -- $argv or return
  set cookies "$HOME/tmp/dash_cookies.txt"

  set result $(gum spin --show-output --title "Setting $_flag_duration minutes dt on $_flag_host..." -- curl -G 'https://dash.37signals.com/chat/chatops' \
    -d 'utf8=%E2%9C%93' \
    -d "bot=chatops" \
    -d "command=dt+$_flag_host+$_flag_duration" \
    -d 'commit=Submit' \
    -b $cookies \
    --silent | grep 'details' | htmlq -t 'details')

  echo (string replace "minutes" "minutes: " $result)
end
