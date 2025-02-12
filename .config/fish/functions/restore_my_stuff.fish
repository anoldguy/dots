function restore_my_stuff --description "restores my stuff from the homelab using restic"
    set -x RESTIC_REPOSITORY sftp:homelab:/home/nathan/backups/restic
    set -x RESTIC_PASSWORD (gum input --password --placeholder "Enter `restic` password")
    for dir in $(jq -r '.local[]' ~/.config/backup_dirs.json | gum choose --no-limit)
      echo "About to restore ~/$dir"
      sleep 5
      restic restore --target /home/nathan --path /home/nathan/$dir latest:/home/nathan
    end
end
