#### Constants ####

FORMAT="%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))"

#### General ####

# Improved git log
alias lg="git log --graph --all --decorate"

# Shortcut + verbose
alias fe="git fetch -v"

# Shortcut + enable Perl regex grep
alias gg="git grep -P "

# Shortcut for stash
alias gpush="git stash"

# Shortcut for stash
alias gpop="git stash apply"

# Show the content of the top change in stash. gss = Git Stash Show
alias gss="git stash show -p"

# Shortcut for git stash drop
alias gsd="git stash drop"

# Git stash list files changed
alias gsl="git stash show"

# Shortcut for rebase continue 
alias cont="git rebase --continue"

# Shortcut for rebase abort 
alias abort="git rebase --abort"

# Shortcut for rebase skip 
alias skip="git rebase --skip"

# Shortcut for status
alias st="git status"

# Shortcut for cherry pick
alias gcp="git cherry-pick"

# Shortcut for review
alias review="git review"

# Updates submodules Note: Equivelant to "git submodule sync && git submodule update"?
alias updatesub="git submodule update --recursive --init"

# Rename a file, normally case differences in git name to local name
alias gmv="git mv -f "

# Delete all non-commited files (- etags file)
alias nuke="git clean -fdx -e ".tags" -e \".tags_sorted_by_file\""

#### Commitments ####

# Commit modified and deleted file changes. Brings up set text editor for message
co() { git add -u && git commit; } 

# Commit modified and deleted file changes with the given commit message
co_m() { git add -u && git commit -m $1; } 

# Commit changes and ammend to last commit
alias co_am="git add -u && git commit --amend --no-edit"

# Commit changes and ammend to last commit + edit the commit message
alias co_am_ed="git add -u && git commit --amend"

# Undo the last commit, making them uncommited changes
alias reset="git reset HEAD~"

# Discard all non-commited changes
alias discard="git stash save --keep-index && git stash drop"

# Reset back to the state before the last executed command. Use as an "undo" command
alias gundo="git reset HEAD@{1}"

# Undo last commit by reseting and discard the changes
undo_last() { reset && discard; }

#### Conflicts ####

# list all conflicted files
conf_ls() { git diff --name-only --diff-filter=U; }

# open conflicted files in sublime
alias conf_subl="conf_ls && conf_ls xargs $SUBL_ALIAS"

# add the conflicted files after you fix them
conf_add() { git diff --name-only --diff-filter=U | xargs git add; }

# Resolve conflict by discarding local changes
conf_ours() { git diff --name-only --diff-filter=U | xargs git checkout --ours; }

#### Branches ####

# View all local branches
alias br="git branch"

# View all remote and local branches
alias remotebr="git branch -a"

# Checkout to another branch
alias switch="git checkout "

# Rename a branch
alias mvbranch="git branch -m "

# Forces a deletion on the branch
rmbr() { git branch -D $1; }

# Delete a remote branch
alias rmbr_remote="git push origin --delete "

# Create new branch based off origin/master and checkout into the given name
cdbranch () { git checkout -b $1 remotes/origin/master; }

# Print the name of the current branch
currbr() { git rev-parse --abbrev-ref HEAD; }

# Fetches origin and rebases for this branch
rebbr() { git fetch origin && git rebase origin/$(currbr) --stat; }

# Fetches origin and rebases ontop on master
rebor() { git fetch origin && git rebase origin/master --stat; }

# Fetches origin and rebases ontop on master and switches to origin/master
rebmaster() { git fetch origin && git rebase origin/master --stat && git checkout origin/master; }

# Resets the current branch to the latest branch whille ignoring local changes
pull_ignore_local() { git fetch origin && git reset --hard origin/$(currbr); }

# View last 10 local branches sorted by last commit in descending order
alias brst="git for-each-ref --sort=-committerdate --count=10 refs/heads/ --format='$FORMAT'"

# View all local branches sorted by last commit in ascending order
alias brsort="git for-each-ref --sort=committerdate refs/heads/ --format='$FORMAT'"

# View all remote branches sorted by last commit in ascending order
alias remotebrsort="git for-each-ref --sort=committerdate refs/remotes/ --format='$FORMAT' | tail -10"

# Check if the given branch has not been altered in over 4 weeks
_br_la() { git log -1 --after='4 weeks ago' -s $1; }

# TODO: add comment stating if branch has been merged with master
# TODO: echo "Deleted <branch>" correctly
rm_od ()
{
    for k in $(git branch | sed /\*/d); do 
    # NOTE: change '-z' to '-n' to filter by BEFORE date
      if [ -z "$(_br_la $k)" ]; then
        # git branch -D $k
        echo "Comfirm deletion of branch $(git log -1 --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'$k)?"
            while true; do
            read -s -n 1 C
            case $C in
                [y]* ) $(rmbr $k) && echo "Deleted $k"; break;;
                [n]* ) break;;
                [q]* ) break 2;;
                * ) echo "Please answer y or n.";;
            esac
        done
      fi
    done
}

#### Given File Change ####

# Shortcut and improvement for log on a file (beyond file renames)
lgf () { git log --follow $1; }

# view commit log with changes of given file 
logf () { git log --follow -p $1; }

# view commit log with changes of given file in sublime
logfsubl () { git log --follow -p $1 > $1.log && "$SUBL_FUNC" $1.log && rm $1.log; }

# grep the history of the given file
greph () { git rev-list --all | xargs git grep $1; }

# view reflog log of given file
alias reflogf="git rev-list --all "

#### All File Changes ####

# Shortcut for `git diff`
alias df="git diff"

# View the changes made in the last commit - df = diff last
alias dl="git diff HEAD^ HEAD"

# view the file changed list in the last commit - cl = see last
alias cl="git diff-tree --no-commit-id --name-status -r HEAD^ HEAD"

# view reflog with time info
alias reflog="git reflog --date=iso"

# view the file changed list in the given commit ID
alias cinfo="git diff-tree --no-commit-id --name-status -r "

# List all existing files being tracked by the current branch
tracked() { git ls-tree -r $(currbr) --name-only; }

# Open all tracked files
otracked() { tracked | xargs "$SUBL_FUNC"; }

# view the file changes in the given commit ID
cdiff () { git diff $1^ $1; }

# view all files given author has touched
gtouch () { git log --no-merges --stat --author="$1" --name-only --pretty=format:"" | sort -u; }
