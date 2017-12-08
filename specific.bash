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
  [xam_app]=$XAMARIN_APP_DIR
  [coa]=$COA
  [rome_app]=$ROME_APP
  [cdp1]=$CDP_1
  [cdp2]=$CDP_2
  [cdp3]=$CDP_3
  [cdpmaster]=$CDP_MASTER
  [github]=$PROJECT_ROME_GITHUB
  [pingpong]=$CDP_PINGPONG
  [os]=$MS_OS
  # notes
  [notes]=$NOTES
  [work]=$WORK
  [home]=$MY_HOME
  # Enlistment
  [en]=$MY_ENLISTMENT
  [en_cdp]=$ENLISTMENT_CDP
  [en_appservice]=$ENLISTMENT_APP_CONTRACT
  # Miscellaneous
  [scripts]=$SCRIPTS
  [wsl]=$WSL_HOME
  [secrets]=$SECRET_HOME
  [downloads]=$DOWNLOADS
)

declare -A work_dir_funcs=(
  # Git repos
  [cdp1]=set_cdp1
  [cdp2]=set_cdp2
  [cdp3]=set_cdp3
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
  [sign_in]="$MY_HOME_WIN/rome_sign_in.bash"
)

#### Navigation ALIASES ####

_set_dir() { _execute_func work_dir_funcs $1; }

_navigate() { _execute $1 nav_keys $2; }

# Open a explorer window at the path name - op = OPen
op() { _navigate cygstart $1; }

# Change directory to path name - gt = GO to
go() { _navigate cd $1; _set_dir $1; }

# Check Script
cs() { _execute "$SUBL_FUNC" script_keys $1; }

_send_notification() { curl -s https://api.pushbullet.com/v2/pushes -X POST -u $PUSHBULLET_ACCESS_TOKEN: --header "Content-Type: application/json" --data-binary "{\"type\": \"note\", \"title\":\"$1\", \"body\": \"$2\"}" > /dev/null; }

#### PROGRAM ALIASES ####

adb () { "$ADB" $@; }
xde () { "$XDE" $@; }
msbuild () { "$MSBUILD" $@; }
alias subl="$SUBL_ALIAS"
nuget () { "$NUGET" $@; }
java () { "$JAVA" $@; }
javac () { "$JAVAC" $@; }
javap () { "$JAVAP" $@; }
javah () { "$JAVAH" $@; }
# junit () { "$JUNIT" $@; }
# Didn't work with multiple arguments
# keytool () { "$KEYTOOL" $@; }
alias keytool="$C/Program\ Files/Java/jdk1.8.0_121/jre/bin/keytool.exe"
alias jarsigner="$C/Program\ Files/Java/jdk1.8.0_121/bin/jarsigner.exe"
apksigner () { "$APK_SIGNER" $@; }
zipalign () { "$ZIP_ALIGN" $@; }
dexdump () { "$DEXDUMP" $@; }
alias scons="$C/Python27/scons-2.4.1.bat "
alias cmake="$CMAKE"


# set_android_arrays()
# {
#     declare -g -A taef_keys=(
#         [64_debug]=$CDP_UT_X64_DEBUG
#         [64_release]=$CDP_UT_X64_RELEASE
#         # [86_debug]=$TODO
#         # [86_release]=$TODO
#     )

taef () { "$TAEF" -f $CDP_UT_X64_DEBUG $@; }
taef_release () { "$TAEF" -f $CDP_UT_X64_RELEASE $@; }

# _execute "$TAEF -f" taef_keys $1


alias err="//tkfiltoolbox/tools/839/1.7.2/x86/err "
alias xamarin_sample="cygstart $XAMARIN_APP_DIR/ConnectedDevices.Xamarin.Droid.Sample.sln"
alias xamarin_sdk="cygstart $XAMARIN_PROJ/ConnectedDevices.sln"

# Windows style newline characters can cause issues in Cygwin in certain files.
# Replacement for the command with the same. Removes trailing \r character
# that causes the error `'\r': command not found`
dos2unix () { sed -i 's/\r$//' $1; }


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

set_cdp1() { CURR_CDP="$CDP_1" && CURR_CDP_WIN="$CDP_1_WIN" && set_variables && set_android_arrays; }
set_cdp2() { CURR_CDP="$CDP_2" && CURR_CDP_WIN="$CDP_2_WIN" && set_variables && set_android_arrays; }
set_cdp3() { CURR_CDP="$CDP_3" && CURR_CDP_WIN="$CDP_3_WIN" && set_variables && set_android_arrays; }