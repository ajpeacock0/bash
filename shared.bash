#### CDP ENV VARS ####

# Disks
C="/cygdrive/c"; export C
D="/cygdrive/d"; export D
L="/cygdrive/l"; export L
F="/cygdrive/f"; export F
Z="//anpea-dev/c$"; export Z
X="/cygdrive/x"; export X

# Disks in Windows format
C_WIN="C:"
D_WIN="D:"

# CDP directories
GIT_REPOS="$D/git_repos"
CDP_1="$GIT_REPOS/cdp"
CDP_2="$GIT_REPOS/cdp_2"
CDP_MASTER="$GIT_REPOS/cdp_master"

CDP_1_WIN="$D_WIN\git_repos\cdp"

# Note files directories
WORK="$D/work_files"
WORK_WIN="$D_WIN/work_files"

CYGWIN="$C/cygwin64/home/anpea"
CYGWIN_WIN="$C_WIN/cygwin64/home/anpea"

# Application directories
ADB="$C/tools/adt-bundle-windows-x86_64-20140702/sdk/platform-tools/adb"
MSBUILD="$C/Program Files (x86)/MSBuild/14.0/Bin/MSBuild.exe"
# NOTE: Due to the spaces in the path and the difference between aliases
# and functions, two seperate variables are required
SUBL_ALIAS="$C/Program\ Files/Sublime\ Text\ 3/subl.exe"
SUBL_FUNC="$C/Program Files/Sublime Text 3/subl.exe"

# CDP scripts
SCRIPTS="$CDP_1/tools/scripts"

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
        _print_array keys && return 1
    fi
}