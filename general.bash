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

# open an explorer window in current directory
alias exp="explorer ."

# Display the space available on the HD
alias space="df -h"

# Improved rm for larger files TODO: clean up the need to create this enpty_dir/
alias rmsync="mkdir empty_dir; rsync -a --progress --delete empty_dir/ "

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
