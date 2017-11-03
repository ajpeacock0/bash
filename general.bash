#### Private functions ####

_print_array()
{
    local -n name=$1
    printf "Valid options are"
    for i in "${!name[@]}"
    do
        printf "\n- $i"
    done
}

# $1 is the action to perform
# $2 is the associate array
# $3 is the key / selection
_execute()
{
    local -n keys=$2

    if [ $# -eq 3 ] && [ ${keys[$3]+exists} ]
    then
        "$1" "${keys[$3]}" && return 0
    else 
        # TODO: only display keys prefixed with given string
        _print_array keys && return 1
    fi
}

_execute_opt()
{
    local -n keys=$2

    if [ $# -eq 3 ] && [ ${keys[$3]+exists} ]
    then
        "$1" "${keys[$3]}"
    fi
    return 0
}

_execute_func()
{
    local -n funcs=$1

    if [ $# -eq 2 ] && [ ${funcs[$2]+exists} ]
    then
        "${funcs[$2]}"
    fi
    return 0
}

#### Utility ####

# Improved ls
alias ls="ls -FA"

# Different ls
alias ll="ls -lhFA"

# Improved grep
alias grep="grep --color "

# Search for a file with the name
alias fhere="find . -iname "

# Search for a file containing a string
alias shere="grep -rnw . -e "

# Display the file name containing the string (less detailed shere)
findh () { grep -Rl $1 .; }

# Replaces the contents and filename of str1 to str2
replace () { a=$1; b=$2; grep -Rl "$a" . | xargs sed -i -- s/$a/$b/g; }

# Create and enter directory
mkcd () { mkdir -p $1; cd $1; }

# Shortcut for up directory
alias ..="cd .."

# Opens the directory in Windows or Unix format. If no argument is given, open the current directory
exp () { if [ $# -eq 1 ]; then cygstart $1; else cygstart .; fi; }

# Display the space available on the HD
alias space="df -h"

# Improved rm for larger files TODO: clean up the need to create this enpty_dir/
alias rmsync="mkdir empty_dir; rsync -a --progress --delete empty_dir/ "

display () { typeset -f "$1"; }

#### History ####

# Pressing space after !<command> or !! will show the command to be executed
bind Space:magic-space

# Increase HISTSIZE from 1000 to 10000
HISTSIZE=10000
HISTFILESIZE=11000
# Save timestamp in the history file
HISTTIMEFORMAT="%F %T "
# Don't store duplicates + ifnore commands starting with space
HISTCONTROL=ignoreboth

# Allow "sharing" of history between instances
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
