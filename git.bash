#### Constants ####

FORMAT="%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))"

#### General ####

# Git log graph
alias lg="git log --graph --all --decorate"

# Regular git log
alias log="git log --name-status"

# Shortcut + verbose
alias fe="git fetch -v"

# Shortcut + enable Perl regex grep
alias gg="git grep --perl-regexp --line-number "

alias gg-w="git grep --perl-regexp --line-number --word-regexp "

gg_uniq () { git grep -P $1 | awk -F: '{print $1}' | uniq; }

# Shortcut. gl = Git List
alias gl="git ls-files"

# Shortcut for stash
alias gpush="git stash"

# Shortcut for stash
alias gpop="git stash apply"

# Show the content of the top change in stash. gss = Git Stash Show
alias gss="git stash show -p"

# Shortcut for git stash drop = Git Stash ReMove
alias gsrm="git stash drop"

# Git stash list files changed = Git Stash List
alias gsl="git stash show"

# List the dates the stashes were created = Git Stash Date
alias gsd="git stash list --date=local"

# Shortcut for rebase continue 
alias cont_re="git rebase --continue"

# Shortcut for rebase abort 
alias abort_re="git rebase --abort"

# Shortcut for rebase skip 
alias skip_re="git rebase --skip"

# Shortcut for cherry-pick continue 
alias cont_cp="git cherry-pick --continue"

# Shortcut for cherry-pick abort 
alias abort_cp="git cherry-pick --abort"

# Shortcut for cherry-pick skip 
alias skip_cp="git cherry-pick --skip"

# Shortcut for status
alias st="git status"

# Shortcut for cherry pick
alias gcp="git cherry-pick -x"

# Shortcut for review
alias review="git review"

# Updates submodules Note: Equivelant to "git submodule sync && git submodule update"?
alias updatesub="git submodule update --recursive --init"

# Rename a file, normally case differences in git name to local name
alias gmv="git mv -f "

# Delete all non-commited files (- etags file) TODO: follow up with a `cp_secrets`
gnuke () 
{ 
    echo "Comfirm deletion of the following files? (Remember all non-added files will be removed)"
    git clean -fdxn &&
    while true; do
        read -s -n 1 C
        case $C in
            [y]* ) git clean -fdx -e ".tags" -e \".tags_sorted_by_file\"; break;;
            [n]* ) break;;
            * ) echo "Please answer y or n.";;
        esac
    done
}


# Push to origin HEAD with force
# TODO: Make this rebor, check to see if you still want to push afterwards
submit () { git push origin +HEAD; }

#### Commitments ####

# Adds all untracked files
add_untracked() { echo -e "a\n*\nq\n" | git add -i; } 

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
alias discard="git checkout -- ."

# Reset back to the state before the last executed git command. Use as an "undo" command
alias gundo="git reset HEAD@{1}"

# Undo last commit by reseting and discard the changes
undo_last() { reset && discard; }

# Ignore local content changes to tracked file
alias ignore_changes="git update-index --assume-unchanged"

# Undo `ignore_changes`
alias track_changes="git update-index --no-assume-unchanged"

# View files marked with --assume-unchanged
alias ignored_files="git ls-files -v | grep '^[[:lower:]]'"

# See files checked into git
alias cf="git ls-files -v"

#### Conflicts ####

# list all conflicted files
conf_ls() { git diff --name-only --diff-filter=U; }

# open conflicted files in sublime
conf_subl() { conf_ls && conf_ls | xargs "$SUBL_FUNC"; }

# add the conflicted files after you fix them
conf_add() { git diff --name-only --diff-filter=U | xargs git add; }

# Resolve conflict by discarding local changes
conf_ours() { git diff --name-only --diff-filter=U | xargs git checkout --ours; }

#### Branches ####

# View all local branches
alias br="git branch"

# View all remote and local branches
alias br_remote="git branch -a"

# Checkout to another branch
alias switch="git checkout "

# Rename a branch
alias mvbr="git branch -m "

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

# This will now checkout to the middle commit between now and the last known good commit. If the build succeeds, use `git bisect good`. If it fails, use ``git bisect bad`
bisect() { git bisect start && git bisect bad && git bisect good $1; }

# Note: Reset, rebase and merge all save your original HEAD pointer to ORIG_HEAD. Thus these commands have been run since the rebase you're trying to undo then you'll have to use the reflog.
undo_rebase() { git reset --hard ORIG_HEAD; }

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

alias reorder="git rebase -i HEAD~10"

clear_merged_br () { git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d; }

# View what commits have not been checked into master
cl_br() { git log master.."$1"; }

# Tag the branch then delete it, effectively keeping the branch around without it cluttering your list
archive_br () { git tag archive/$1 $1 && git branch -D $1; }

# Restore the archived branch
restore_br () { git checkout -b $1 archive/$1; }

count_commits () { git shortlog -s -n; }

#### Given File Change ####

# Shortcut and improvement for log on a file (beyond file renames)
lgf () { git log --follow $1; }

# view commit log with changes of given file 
logf () { git log --follow -p $1; }

# view commit log with changes of given file in sublime
logfsubl () { git log --follow -p $1 > $1.log && "$SUBL_FUNC" $1.log && rm $1.log; }

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

# View a list of all deleted files
alias gdeleted="git log --diff-filter=D --summary | grep delete"

# List all existing files being tracked by the current branch
tracked() { git ls-tree -r $(currbr) --name-only; }

# Open all tracked files
otracked() { tracked | xargs "$SUBL_FUNC"; }

# view the file changes in the given commit ID
cdiff () { git diff $1^ $1; }

# view all files given author has touched
gtouch () { git log --no-merges --stat --author="$1" --name-only --pretty=format:"" | sort -u; }

# View all the commits I have merged
my_commits () { git log --author="anpea"; } 

# Perform a "git grep" including the history of the files
greph () { git rev-list --all | xargs git grep "$1"; }

get_unstaged_files() { git diff --name-only; }

get_staged_files() { git diff --staged --name-only --diff-filter=ACMRT; }

untrack() { git rm -r --cached $1; } 

rm_untracked () 
{ 
    echo "Comfirm deletion of the following files? (Remember all non-added files will be removed)"
    git clean -n &&
    while true; do
        read -s -n 1 C
        case $C in
            [y]* ) git clean -f; break;;
            [n]* ) break;;
            * ) echo "Please answer y or n.";;
        esac
    done
}

# Adds the worktree with the given directory name. Run this in the main repo
add_worktree() { git worktree prune && git worktree add ../$1 master; }


# Optimized `replace` for use in a git repository
greplace () { a=$1; b=$2; git grep --files-with-matches "$a" | xargs sed -i -- s/$a/$b/g; }

# Rename files in git directory
grename () { a=$1; b=$2; for old_file in $(git ls-files "*$a*"); do new_file=$(echo $old_file | sed -En "s/$a/$b/p"); git mv -f $old_file $new_file; done; }