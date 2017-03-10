#### CDP ENV VARS ####

# Disks
C="/cygdrive/c"; export C
L="/cygdrive/l"; export L
F="/cygdrive/f"; export F
Z="//anpea-dev/c$"; export Z
X="/cygdrive/x"; export X

# CDP directories
CDP_1="$C/git_repos/cdp"; export CDP
CDP_2="$C/git_repos/cdp_2"; export CDP_2
CDP_MASTER="$C/git_repos/cdp_master"; export CDP_MASTER
XAMARIN="$C/git_repos/project-rome/xamarin"; export XAMARIN
XAMARIN_APK="$XAMARIN/samples/ConnectedDevices.Xamarin.Droid.Sample/ConnectedDevices.Xamarin.Droid.Sample/bin/x86/Debug"; export XAMARIN_APK
XAMARIN_DLL="$XAMARIN/src/ConnectedDevices.Xamarin.Droid/bin/x86/Debug"; export XAMARIN_DLL
ENLISTMENT_CDP="$F/enlistments/onecoreuap/windows/cdp"; export ENLISTMENT_CDP
ENLISTMENT_APP_CONTRACT="$F/enlistments/onecoreuap/base/appmodel/AppContracts"; export ENLISTMENT_APP_CONTRACT
COA="$C/git_repos/CortanaAndroid"; export COA
TDD="$C/git_repos/cdp/build/onecorefast/x64/debug/tests"; export TDD
ROMAN="$C/git_repos/cdp/samples/romanapp/android"; export ROMAN
ROME_INTERN_APK="$ROMAN/internal/build/outputs/apk"; export ROME_INTERN_APK

# Log directories
SYS_CDP="$C/Windows/ServiceProfiles/LocalService/AppData/Local/ConnectedDevicesPlatform"
USER_CDP="$C/Users/anpea/AppData/Local/ConnectedDevicesPlatform"

THIS_PC="C:\\Windows\\ServiceProfiles\\LocalService\\AppData\\Local"; export THIS_PC

SYS_CDP_WIN="C:\\Windows\\ServiceProfiles\\LocalService\\AppData\\Local\\ConnectedDevicesPlatform"
USER_CDP_WIN="C:\\Users\\anpea\\AppData\\Local\\ConnectedDevicesPlatform"

DEVBOX="\\\\ANPEA-DEV"; export DEVBOX

# Private files directories
WORK="$C/work_files"; export WORK
NOTES="$C/notes/"; export NOTES
BASHRC="$C/cygwin64/home/anpea"; export BASHRC

# Network directories
VM_DIR="//winbuilds/release/RS_ONECORE_DEP_ACI_CDP/"; export VM_DIR
ANPEA_DIR="//redmond/osg/release/DEP/CDP/anpea"; export ANPEA_DIR
ROME_DROP="//redmond/osg/release/dep/CDP/V3Partners/Rome_1701"; export ROME_DROP

# VM Names
CDP1_VM="\\\\DESKTOP-5MMAKOD"; export CDP1_VM
CDP2_VM="\\\\DESKTOP-4HQ4UEA"; export CDP2_VM
MASTER_VM="\\\\DESKTOP-CTKCQFE"; export MASTER_VM
RS1_VM="\\\\DESKTOP-KDTTPVC"; export RS1_VM
OFFICIAL_VM="\\\\DESKTOP-NM3ECF2"; export OFFICIAL_VM

LAPTOP="\\\\DESKTOP-02BI2KL"; export LAPTOP

# Application directories
ADB="$C/tools/adt-bundle-windows-x86_64-20140702/sdk/platform-tools/adb"; export ADB
SUBL="$C/Program\ Files/Sublime\ Text\ 3/subl.exe"
MY_JAVA_HOME="$C/Program\ Files/Java/jdk1.8.0_121"
JAVAC="$MY_JAVA_HOME/bin/javac.exe"
JAVAP="$MY_JAVA_HOME/bin/javap.exe"
VS="$C/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio\ 14.0/Common7/IDE/devenv.exe"

# Android directories
CDP_HOST_NAME="com.microsoft.cdp.CDPHost"
CORTANA_NAME="com.microsoft.cortana"
TDDRUNNER_NAME="com.microsoft.tddrunner"
ROMAN_APP_NAME="com.microsoft.romanapp"
ROMAN_APP_INTERNAL_NAME="com.microsoft.romanappinternal"
XAMARIN_APP_NAME="ConnectedDevices.Xamarin"

CDP_HOST="sdcard/Android/data/$CDP_HOST_NAME/files"
CORTANA="sdcard/Android/data/$CORTANA_NAME/files"
TDDRUNNER="sdcard/Android/data/$TDDRUNNER_NAME/files"
ROMAN_APP="sdcard/Android/data/$ROMAN_APP_NAME/files"
ROMAN_APP_INTERNAL="sdcard/Android/data/$ROMAN_APP_INTERNAL_NAME/files"
XAMARIN_APP="sdcard/Android/data/$XAMARIN_APP_NAME/files"

DDR_LOC="$WORK/bug_files/CoA_testing"
COA_BUILDS="$WORK/bug_files/coa_builds"

#### CD ALIASES ####

alias cdp1="cd $CDP_1"
alias cdp2="cd $CDP_2"
alias master="cd $CDP_MASTER"
alias xamarin="cd $XAMARIN"
alias xamarin_apk="cd $XAMARIN_APK"
alias xamarin_dll="cd $XAMARIN_DLL"
alias en_cdp="cd $ENLISTMENT_CDP"
alias en_appservice="cd $ENLISTMENT_APP_CONTRACT"
alias coa="cd $COA"
alias tdd="cd $TDD"
alias romanapp="cd $ROMAN"
alias rome_intern_apk="cd $ROME_INTERN_APK"
alias work="cd $WORK"
alias notes="cd $NOTES"
alias l2="cd $CDP_WIN10"
alias l2cdp="cd $CDP_WIN10/onecoreuap/windows/cdp"
alias vms="cd $VM_DIR"
alias sys_cdp="cd $SYS_CDP"
alias user_cdp="cd $USER_CDP"
alias anpea_dir="cd $ANPEA_DIR"
alias rome_drop="cd $ROME_DROP"
alias coa_builds="cd $COA_BUILDS"
alias cygwin="cd $BASHRC"

#### PROGRAM ALIASES ####

alias adb="$ADB"
alias subl="$SUBL"
alias javac="$JAVAC"
alias javap="$JAVAP"
# my guess why this isn't working is .bashrc doesn't know how to execute .exe files, but there cygwin shell from the command line does.
# The alias runs `/cygdrive/c/Program\ Files/Sublime\ Text\ 3/subl.exe` in the command line, where as the function tires to run 
# `/cygdrive/c/Program\ Files/Sublime\ Text\ 3/subl.exe` inside the .bashrc
# subl2() { source "$SUBL"; }
# subl3() { "/cygdrive/c/Program\ Files/Sublime\ Text\ 3/subl.exe"; }

alias bashrc="$SUBL .bashrc"
alias xbashrc="$SUBL $X/.bashrc"

alias scons="$C/Python27/scons-2.4.1.bat "

alias err="//tkfiltoolbox/tools/839/1.7.2/x86/err "
alias puen="scons platform=onecore no_build=1"

alias vs1="$VS -nosplash $CDP_1/core/CDP_gen.vcxproj &"
alias vs2="$VS -nosplash $CDP_2/core/CDP_gen.vcxproj &"

#### CDP Traces ####

alias rm_sys_log="rm $SYS_CDP/CDPTraces.log"
alias rm_user_log="rm $USER_CDP/CDPTraces.log"

alias sys_log="$SUBL \"$SYS_CDP_WIN\"\\\\CDPTraces.log"
alias user_log="$SUBL \"$USER_CDP_WIN\"\\\\CDPTraces.log"

alias cd_user_log='cd $USER_CDP_WIN'

#### DOWNLOAD VM ALIASES ####

# go to the latest build directory
latest () { cd $VM_DIR; ls | sort | tail -1; cd `ls | sort | tail -1`; }

# go to the $1th latest build directory
vmn () { cd $VM_DIR; ls | sort | tail -$1 | head -1; cd `ls | sort | tail -$1 | head -1`; }

# print the latest build with amd64 VHD
vm64 () { for var in {1..10}; do cd $VM_DIR; ls | sort | tail -$var | head -1; cd `ls | sort | tail -$var | head -1`; if [ -d "amd64fre/vhd/" 
]; then echo "$var : amd64fre exists"; break; fi; done; }

# print the latest build with x86 VHD
vm86 () { for var in {1..10}; do cd $VM_DIR; ls | sort | tail -$var | head -1; cd `ls | sort | tail -$var | head -1`; if [ -d "x86fre/vhd/" ]; 
then echo "$var : x86fre exists"; break; fi; done; }

# copy a x64 VHD to local drive
alias cpvm="rsync -a --progress amd64fre/vhd/vhd_client_enterprise_en-us_vl/* $C/VHDs/"

# copy a x84 VHD to local drive
alias cpvm86="rsync -a --progress x86fre/vhd/vhd_client_enterprise_en-us_vl/* $C/VHDs/"

# copy a x64 sfpcopy.exe to the VHD directory
alias cpsfp="rsync -a --progress amd64fre/bin/idw/sfpcopy.exe $C/VHDs/"

# copy a x86 sfpcopy.exe to the VHD directory
alias cpsfp86="rsync -a --progress x86fre/bin/idw/sfpcopy.exe $C/VHDs/"

sfp64 () { for var in {1..10}; do cd $VM_DIR; ls | sort | tail -$var | head -1; cd `ls | sort | tail -$var | head -1`; if [ -d 
"amd64fre/bin/idw/sfpcopy.exe" ]; then echo "$var : sfpcopy.exe exists"; break; fi; done; }

# NOT WORKING
sfp86 () { for var in {1..10}; do cd $VM_DIR; ls | sort | tail -$var | head -1; cd `ls | sort | tail -$var | head -1`; if [ -d 
"x86fre/bin/idw/sfpcopy.exe" ]; then echo "$var : sfpcopy.exe exists"; break; fi; done; }

#### ANDROID GENERAL ALIASES ####

ls_devices () { adb devices | grep "device$" | sed 's/ *device//g'; }

ls_device () { adb devices | grep "device$" | sed 's/ *device//g' | sed -n "$1"p; }

# Delete the CDP log
app_rm_log () { $ADB shell rm $1/CDPTraces.log; }

# Pull the CDP log
app_pull_log () { $ADB pull $1/CDPTraces.log CDPTraces.log; }

# Close application
app_stop () { adb shell am force-stop $1; }

# Close app process and clear out all the stored data for that app.
app_nuke () { adb shell pm clear $1; }

# CDP Host commands
cdphost_rm_log () { app_rm_log $CDP_HOST; }
cdphost_pull_log () { app_pull_log $CDP_HOST; }
cdphost_stop () { app_stop $CDP_HOST_NAME; }
cdphost_nuke () { app_nuke $CDP_HOST_NAME; }

# CoA commands
coa_rm_log () { app_rm_log $CORTANA; }
coa_pull_log () { app_pull_log $CORTANA; }
coa_stop () { app_stop $CORTANA_NAME; }
coa_nuke () { app_nuke $CORTANA_NAME; }

# TddRunner commands
tdd_rm_log () { app_rm_log $TDDRUNNER; }
tdd_pull_log () { app_pull_log $TDDRUNNER; }
tdd_stop () { app_stop $TDDRUNNER_NAME; }
tdd_nuke () { app_nuke $TDDRUNNER_NAME; }

# RomanApp commands
rome_rm_log () { app_rm_log $ROMAN_APP; }
rome_pull_log () { app_pull_log $ROMAN_APP; }
rome_stop () { app_stop $ROMAN_APP_NAME; }
rome_nuke () { app_nuke $ROMAN_APP_NAME; }

# RomanApp commands
rome_intern_rm_log () { app_rm_log $ROMAN_APP_INTERNAL; }
rome_intern_pull_log () { app_pull_log $ROMAN_APP_INTERNAL; }
rome_intern_stop () { app_stop $ROMAN_APP_INTERNAL_NAME; }
rome_intern_nuke () { app_nuke $ROMAN_APP_INTERNAL_NAME; }

# RomanApp commands
xamarin_rm_log () { app_rm_log $XAMARIN_APP; }
xamarin_pull_log () { app_pull_log $XAMARIN_APP; }
xamarin_stop () { app_stop $XAMARIN_APP_NAME; }
xamarin_nuke () { app_nuke $XAMARIN_APP_NAME; }

#### ANDROID SPECIFIC ALIASES ####

clean_android () { rm -rf "$CDP_1/core/android/build" && rm -rf "$CDP_1/sdk/android/build" && rm -rf 
"$CDP_1/samples/CDPHost/android/app/build";  }

clean_cdphost () { rm -rf "$CDP_1/samples/CDPHost/android/app/build";  }

clean_coa () { rm -rf "$COA/DSS/AuthLib/build"; }

aar () { cd "$CDP_1/sdk/android/3p/build/outputs/aar"; }

cp_arr_internal () { cp "$CDP_1/$1/android/build/outputs/aar/connecteddevices-$1-armv7-internal-release.aar" 
"$COA/DSS/BuildDependencies/shared"; }
cp_arr () { $(cp_arr_internal sdk) && $(cp_arr_internal core) ; }

rm_log () { rm "$1/ConnectedDevicesPlatform/CDPTraces.log"; }

store_vm_log () { if [ $# -eq 0 ]; then echo "No arguments provided"; exit 1; fi; dmkdir && cp "$1\ConnectedDevicesPlatform\CDPTraces.log" 
"$DDIR\CDPTraces_PC.log" && cd "$DDIR"; }

# Store the CoA log and given desktop directory log to a timestamp directory e.g. store_coa $CDP1_VM
store_coa () { if [ $# -eq 0 ]; then echo "No arguments provided"; exit 1; fi; coa_pull_log && dmkdir && mv CDPTraces.log 
"$DDIR\CDPTraces_android.log" && cp "$1\ConnectedDevicesPlatform\CDPTraces.log" "$DDIR\CDPTraces_PC.log" && cd "$DDIR"; }

# Store the RomanApp log and given desktop directory log to a timestamp directory e.g. store_coa $CDP1_VM
store_rome () { if [ $# -eq 0 ]; then echo "No arguments provided"; exit 1; fi; rome_pull_log && dmkdir && mv CDPTraces.log 
"$DDIR\CDPTraces_android.log" && cp "$1\ConnectedDevicesPlatform\CDPTraces.log" "$DDIR\CDPTraces_PC.log" && cd "$DDIR"; }

# Store the RomanAppInternal log and given desktop directory log to a timestamp directory e.g. store_coa $CDP1_VM
store_rome_intern () { if [ $# -eq 0 ]; then rome_intern_pull_log && dmkdir && mv CDPTraces.log "$DDIR\CDPTraces_android.log" && cd "$DDIR"; 
else rome_intern_pull_log && dmkdir && mv CDPTraces.log "$DDIR\CDPTraces_android.log" && cp "$1\ConnectedDevicesPlatform\CDPTraces.log" 
"$DDIR\CDPTraces_PC.log" && cd "$DDIR"; fi; }

# Store the CDPHost log and given desktop directory log to a timestamp directory e.g. store_coa $CDP1_VM
store_cdphost () { if [ $# -eq 0 ]; then echo "No arguments provided"; exit 1; fi; cdphost_pull_log && dmkdir && mv CDPTraces.log 
"$DDIR\CDPTraces_android.log" && cp "$1\ConnectedDevicesPlatform\CDPTraces.log" "$DDIR\CDPTraces_PC.log" && cd "$DDIR"; }

# Run TDD on Android with the input. If $2 is set, use it, otherwise pass 1
tdd_run () { repeat=${2-1}; adb shell am start -S -n $TDDRUNNER_NAME/.TddRunner --es name $1 --ei repeat $repeat; }

# Run TDD on Android with the input in debug mode. If $2 is set, use it, otherwise pass 1
tdd_run_deb () { repeat=${2-1}; adb shell am start -S -D -n $TDDRUNNER_NAME/.TddRunner --es name $1 --ei repeat $repeat; }

# Generate Date Time Stamp - MM.DD.YYYY
dts2 () { date +%m.%d.%Y; }

# Create a directory with timestamp
make_drop_dirs () { CURR_DROP="$ROME_DROP/$(dts2)"; export CURR_DROP; mkdir $CURR_DROP; mkdir "$CURR_DROP\armv7"; mkdir 
"$CURR_DROP\armv7\symbols"; }

cp_arr_external () { cp "$CDP_1/$1/android/build/outputs/aar/connecteddevices-$1-armv7-internal-$2.aar" 
"$ROME_DROP/$(dts2)/armv7/connecteddevices-$1-armv7-internal-$2.aar"; }
cp_arrs_external () { $(cp_arr_external core debug); $(cp_arr_external core release); $(cp_arr_external sdk debug); $(cp_arr_external sdk 
release); }

cp_so_external () { cp "$CDP_1/core/android/build/intermediates/jniLibs/internal/release/armeabi-v7a/libCDP_internal.$1" 
"$ROME_DROP/$(dts2)/armv7/symbols/libCDP_internal.$1"; }
cp_sos_external () { $(cp_so_external so); $(cp_so_external so.debug); }

cp_so_java_external () { cp "$CDP_1/sdk/android/src/internalRelease/jniLibs/armeabi-v7a/libCDP_java_internal.$1" 
"$ROME_DROP/$(dts2)/armv7/symbols/libCDP_java_internal.$1"; }
cp_sos_java_external () { $(cp_so_java_external so); $(cp_so_java_external so.debug); }

drop_coa () { $(make_drop_dirs) && $(cp_arrs_external); $(cp_sos_external); $(cp_sos_java_external); }

#### UTILITY ALIASES ####

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

# Generate Date Time Stamp
dts() { date +%Y-%m-%d-%H-%M-%S; }

# Create a directory with timestamp
dmkdir() { DDIR="$DDR_LOC/$(dts)"; export DDIR; mkdir $DDIR; }

# Date mv
mvd() { $(dmkdir); for f in "$@"; do mv $f $DDR_LOC/$(dts); done }

# Date copy
cpd() { $(dmkdir); for f in "$@"; do cp $f $DDR_LOC/$(dts); done }

cpf() { $(dmkdir); cp $1 $DDR_LOC/$(dts)/$2; }

#### GIT ALIASES: General ####

# Shortcut for log
alias lg="git log"

# Shortcut + verbose
alias fe="git fetch -v"

# Shortcut + enable Perl regex grep
alias gg="git grep -P "

# Shortcut for stash
alias gpush="git stash"

# Shortcut for stash
alias gpop="git stash apply"

# Shortbut for diff stash
alias gds="git stash show -p"

# Continue shortcut
alias cont="git rebase --continue"

# Abort shortcut
alias abort="git rebase --abort"

# Skip shortcut
alias skip="git rebase --skip"

# Shortcut for status
alias st="git status"

# Shortcut for review
alias review="git review"

# Updates submodules TODO: find the difference and which command is better
alias updatesub="git submodule update --recursive --init"
#alias updatesub="git submodule sync && git submodule update"

# Rename a file, normally case differences in git name to local name
alias gitmv="git mv -f "

# Delete all non-commited files
alias nuke="git clean -fdx -e ".tags" -e \".tags_sorted_by_file\""

#### GIT ALIASES: Commitments ####

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

# Erase all non-commited changes
alias revert="git stash save --keep-index && git stash drop"

# git checkout origin/cdp1702 && git fetch http://cdp-cr/cdp refs/changes/58/3458/2 && git cherry-pick FETCH_HEAD

alias gcp="git cherry-pick"

# http://cdp-cr/#/c/3507/

# git co origin/cdp1702_2
# git cp -x <commit id>
# git review cdp1702_2

#### GIT ALIASES: Conflicts ####

# list all conflicted files
conf_ls() { git diff --name-only --diff-filter=U; }

# open conflicted files in sublime
conf_subl() { $(conf_ls) && git diff --name-only --diff-filter=U | xargs $SUBL; }

# add the conflicted files after you fix them
conf_add() { git diff --name-only --diff-filter=U | xargs git add; }

# add the conflicted files after you fix them
conf_ours() { git diff --name-only --diff-filter=U | xargs git checkout --ours; }

#### GIT ALIASES: Branches ####

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

# View last 10 local branches sorted by last commit in descending order
alias brst="git for-each-ref --sort=-committerdate --count=10 refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - 
%(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"

# View all local branches sorted by last commit in ascending order
alias brsort="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - 
%(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"

# View all remote branches sorted by last commit in ascending order
alias remotebrsort="git for-each-ref --sort=committerdate refs/remotes/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - 
%(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))' | 
tail -10"

alias remotebrcoa="git for-each-ref --sort=committerdate refs/remotes/origin/coa* --format='%(HEAD) 
%(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) 
(%(color:green)%(committerdate:relative)%(color:reset))' | tail -10"

# List latest branches
br_la() { git log -1 --after='4 weeks ago' -s $1; }

# TODO: add comment stating if branch has been merged with master
# TODO: echo "Deleted <branch>" correctly
rm_od ()
{
    for k in $(git branch | sed /\*/d); do 
    # NOTE: change '-z' to '-n' to filter by BEFORE date
      if [ -z "$(br_la $k)" ]; then
        # git branch -D $k
        echo "Comfirm deletion of branch $(git log -1 --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' 
$k)?"
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

# Create new branch based off origin/master and checkout into the given name
cdbranch () { git checkout -b $1 remotes/origin/master; }

# Print the name of the current branch
currbr() { git rev-parse --abbrev-ref HEAD; }

# Fetches origin and rebases for this branch
rebbr() { git fetch origin && git rebase origin/$(currbr) --stat; }

# Fetches origin and rebases ontop on master
rebandroid() { git fetch origin && git rebase origin/android_1611 --stat; }

# Fetches origin and rebases ontop on master
rebor() { git fetch origin && git rebase origin/master --stat; }

# Fetches origin and rebases ontop on master and switches to origin/master
rebmaster() { git fetch origin && git rebase origin/master --stat && git checkout origin/master; }

# Fetches origin, rebases ontop on master and reviews the change
# submit() { $(rebor) && git review; } - doesn't work

pull_ignore_local() { git reset --hard origin/$(currbr); }

# Push latest fetched Gerrit branch to VSO `push_vso <branch>` e.g. `push_vso master`
# push_vso() { git push vso origin/$1:$1 }

#### GIT ALIASES: Given File Change ####

# Shortcut and improvement for log on a file (beyond file renames)
lgf () { git log --follow $1; }

# view commit log with changes of given file 
logf () { git log --follow -p $1; }

# view commit log with changes of given file in sublime
logfsubl () { git log --follow -p $1 > $1.log && $SUBL $1.log && rm $1.log; }

# grep the history of the given file
greph () { git rev-list --all | xargs git grep $1; }

# view reflog log of given file
alias reflogf="git rev-list --all "

#### GIT ALIASES: All File Changes ####

# Shortcut for `git diff`
alias gdf="git diff"

# View the changes made in the last commit - df = diff last
alias dl="git diff HEAD^ HEAD"

# List the files changed in the last commit - df = diff last list
alias dll="git diff --name-only HEAD^ HEAD"

# view the file changed list in the last commit - cl = see_last
alias cl="git diff-tree --no-commit-id --name-status -r HEAD^ HEAD"

# view reflog with time info
alias reflog="git reflog --date=iso"

# view the file changed list in the given commit ID
alias cinfo="git diff-tree --no-commit-id --name-status -r "

# view the file changes in the given commit ID
cdiff () { git diff $1^ $1; }

# view all files given author has touched
gtouch () { git log --no-merges --stat --author="$1" --name-only --pretty=format:"" | sort -u; }

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

alias op=" !! | tail -"

# export HISTCONTROL=ignoreboth
# HISTIGNORE='rm *:svn revert*'

# Allow "sharing" of history between instances
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
