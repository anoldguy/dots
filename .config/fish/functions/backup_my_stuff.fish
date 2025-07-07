function backup_my_stuff --description "Backs up my stuff using restic"
    set -x RESTIC_REPOSITORY /backups/nathan/backups/restic
    set -x RESTIC_PASSWORD (gum input --password --placeholder "Enter `restic` password")
    for dir in $(jq -r '.local[]' ~/.config/backup_dirs.json)
      echo "About to backup ~/$dir"
      restic backup --skip-if-unchanged ~/$dir
    end
end
