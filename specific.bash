declare -A nav_keys=(
  # Build files
  [xam_apk]=$XAMARIN_APK
  [xam_dll]=$XAMARIN_DLL
  [sdk_aar]=$SDK_3P_AAR
  [rome_apk]=$ROME_IN_APK_DIR
  # System logs
  [cdpsvc]=$SYS_CDP
  [cdpusersvc]=$USER_CDP
  # Network
  [network_dir]=$MY_NETWORK_DIR
  [drop]=$ROME_DROP
  [vms]=$VM_DIR
  # Git repos
  [xam_proj]=$XAMARIN_PROJ
  [xam_app]=$XAMARIN_APP
  [coa]=$COA
  [rome_app]=$ROME_APP
  [cdp1]=$CDP_1
  [cdp2]=$CDP_2
  [cdpmaster]=$CDP_MASTER
  [github]=$PROJECT_ROME_GITHUB
  [pingpong]=$CDP_PINGPONG
  # notes
  [work]=$WORK
  [home]=$MY_HOME
  # Enlistment
  [en]=$MY_ENLISTMENT
  [en_cdp]=$ENLISTMENT_CDP
  [en_appservice]=$ENLISTMENT_APP_CONTRACT
  # Miscellaneous
  [scripts]=$SCRIPTS
  [wsl]=$WSL_HOME
)

declare -A script_keys=(
  # Bash
  [inputrc]="$MY_HOME_WIN/.inputrc_custom"
  [android]="$MY_HOME_WIN/android.bash"
  [general]="$MY_HOME_WIN/general.bash"
  [git]="$MY_HOME_WIN/git.bash"
  [main]="$MY_HOME_WIN/main.bash"
  [vars]="$MY_HOME_WIN/variables.bash"
  [specific]="$MY_HOME_WIN/specific.bash"
)

#### Navigation ALIASES ####

_navigate() { _execute $1 nav_keys $2; }

# Open a explorer window at the path name - op = OPen
op() { _navigate cygstart $1; }

# Change directory to path name - gt = GO to
go() { _navigate cd $1; }

# Check Script
cs() { _execute "$SUBL_FUNC" script_keys $1; }

#### PROGRAM ALIASES ####

alias adb="$ADB"
msbuild () { "$MSBUILD" $@; }
alias subl="$SUBL_ALIAS"
nuget () { "$NUGET" $@; }
javac () { "$JAVAC" $@; }
javap () { "$JAVAP" $@; }
javah () { "$JAVAH" $@; }
alias keytool="$KEYTOOL"
alias apksigner="$APK_SIGNER"
alias scons="$C/Python27/scons-2.4.1.bat "
alias cmake="$CMAKE"

alias err="//tkfiltoolbox/tools/839/1.7.2/x86/err "
alias xamarin_sample="cygstart $XAMARIN_APP/ConnectedDevices.Xamarin.Droid.Sample.sln"
alias xamarin_sdk="cygstart $XAMARIN_PROJ/ConnectedDevices.sln"

# Windows style newline characters can cause issues in Cygwin in certain files.
# Replacement for the command with the same. Removes trailing \r character
# that causes the error `'\r': command not found`
dos2unix () { sed -i 's/\r$//' $1; }

#### CDP Traces ####

qsvc() { sc queryex cdpsvc; }

# Note: Requires Admin
stopsvc() { sc stop cdpsvc; }
startsvc() { sc start cdpsvc; }
disablesvc() { sc config cdpsvc start=disabled; }
enablesvc() { sc config cdpsvc start=demand; }

alias rm_sys_log="stopsvc && rm $SYS_CDP_WIN\\\\CDPTraces.log && startsvc"
alias rm_user_log="rm $USER_CDP_WIN\\\\CDPTraces.log"

alias sys_log="$SUBL_ALIAS $SYS_CDP_WIN\\\\CDPTraces.log"
alias user_log="$SUBL_ALIAS $USER_CDP_WIN\\\\CDPTraces.log"