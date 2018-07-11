#### PROGRAM ALIASES ####

adb () { "$ADB" $@; }
alias subl="$SUBL_ALIAS"
alias cmake="$CMAKE"
alias taef="$TAEF"
alias dumpbin="$DUMPBIN"

# Alias to internal Windows error code lookup
alias err="//tkfiltoolbox/tools/839/1.7.2/x86/err "

alias updot="python $GIT_REPOS_WIN/updot/updot.py"

# Windows style newline characters can cause issues in Cygwin in certain files.
# Replacement for the command with the same. Removes trailing \r character
# that causes the error `'\r': command not found`
dos2unix () { sed -i 's/\r$//' $1; }

export PYTHONIOENCODING="utf-8"
function fuck () {
    TF_PYTHONIOENCODING=$PYTHONIOENCODING;
    export TF_ALIAS=fuck;
    export TF_SHELL_ALIASES=$(alias);
    export TF_HISTORY=$(fc -ln -10);
    export PYTHONIOENCODING=utf-8;
    TF_CMD=$(
        thefuck THEFUCK_ARGUMENT_PLACEHOLDER $@
    ) && eval $(sed 's/\r$//' <<< $TF_CMD); # Remove the Windows EOL char[s]
    unset TF_HISTORY;
    export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
    history -s $TF_CMD;
}

#### CDP Traces ####

qsvc() { sc queryex cdpsvc; }

# Note: Requires Admin
stop_svc() { sc stop cdpsvc; }
start_svc() { sc start cdpsvc; }
disable_svc() { sc config cdpsvc start=disabled; }
enable_svc() { sc config cdpsvc start=demand; }

rm_sys_log () { stop_svc; rm $SYS_CDP_WIN\\\\CDPTraces.log && startsvc; };
rm_user_log () { rm $USER_CDP_WIN\\\\CDPTraces.log; };

sys_log () { $SUBL_ALIAS $SYS_CDP_WIN\\\\CDPTraces.log; };
user_log () { $SUBL_ALIAS $USER_CDP_WIN\\\\CDPTraces.log; };

set_cdp1() { CURR_CDP="$CDP_1" && CURR_CDP_WIN="$CDP_1_WIN" && set_variables; }
set_cdp2() { CURR_CDP="$CDP_2" && CURR_CDP_WIN="$CDP_2_WIN" && set_variables; }
set_cdp3() { CURR_CDP="$CDP_3" && CURR_CDP_WIN="$CDP_3_WIN" && set_variables; }