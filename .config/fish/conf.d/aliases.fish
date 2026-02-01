set -q MY_ABBRS_INITIALIZED; and return

if status --is-interactive
    type -q prettyping && alias ping="prettyping --nolegend"
    type -q htop && alias top="htop"
    abbr -a bi bundle install
    abbr -a be bundle exec
    abbr -a k kubectl
    abbr -a kg kubectl get
    abbr -a kgp kubectl get pods
    abbr -a kctx kubectx
    abbr -a kns kubens
    abbr -a kget kubectl get events --sort-by='.lastTimestamp'
    abbr -a kc kubectl config current-context
    abbr -a kde "kubectl get pods | grep Evicted | awk '{print $1}' | xargs -n 1 kubectl delete pod"
    abbr -a dsa "docker ps -aq | xargs docker stop | xargs docker rm"
    abbr -a -- ds 'date +%Y-%m-%d'
    abbr -a -- ts 'date +%Y-%m-%dT%H:%M:%SZ'
    abbr -a -- yyyymmdd 'date +%Y%m%d'
end

# no need to run over-and-over
set -g MY_ABBRS_INITIALIZED true
