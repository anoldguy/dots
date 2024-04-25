function converge_list -d "Converge a list of nodes and track progress"
    argparse 'l/list=' 'r/reverse' 'c/command=?' -- $argv or return

    set listfile $_flag_list
    set command $_flag_command
    set reverse $_flag_reverse
    # Set default command if not provided
    set -q command[1] || set command "sleep 2 && sudo chef-client"

    set -q listfile[1] || return 1
    touch $listfile.done
    cat $listfile | read -za raw
    set host_list $raw

    # Reverse the list if we're asked to
    if set -q reverse[1]
        set host_list $raw[-1..1]
    end

    for host in $host_list
        # We've been asked to stop, exit
        if test -e $listfile.stop
            echo "Stopped by $listfile.stop"
            break
        end

        # If we already processed this node, skip
        if grep -q "^$host\$" $listfile.done
            continue
        end

        # Process this node
        echo $host
        ssh $host "$command"
        if test $status -eq 0
            echo $host >>$listfile.done
        end
    end
end
