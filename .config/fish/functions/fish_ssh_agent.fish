function __ssh_agent_is_started -d "check if ssh agent is already started"
    set -q SSH_AGENT_PID; or return 1
    ps -p $SSH_AGENT_PID > /dev/null
end


function __ssh_agent_start -d "start a new ssh agent"
    ssh-agent -c | grep -v echo > $SSH_ENV
    chmod 600 $SSH_ENV
    source $SSH_ENV > /dev/null
    if is_mac
        ssh-add --apple-use-keychain --apple-load-keychain -q >/dev/null 2>&1 # Ensure we add keys when we start an agent
    else
        ssh-add -q
    end
    true # suppress errors from setenv, i.e. set -gx
end


function fish_ssh_agent --description "Start ssh-agent if not started yet, or uses already started ssh-agent."
    set -q SSH_ENV; or set -xg SSH_ENV $HOME/.ssh/environment
    source $SSH_ENV > /dev/null

    __ssh_agent_is_started; or __ssh_agent_start
end
