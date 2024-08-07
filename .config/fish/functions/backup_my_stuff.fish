function backup_my_stuff --description "Backs up my stuff to the homelab using today's date."
    set session_date $(date +"%Y-%m-%d_%H%M")
    for dir in $(jq -r '.local[]' ~/.config/backup_dirs.json)
      ssh homelab mkdir -p ~/backups/nathan-$session_date
      rsync -avz $dir homelab:~/backups/nathan-$session_date/
    end
end
