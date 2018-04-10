#### Dictionaries ####

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
  [repos]=$GIT_REPOS
  [rome_app]=$ROME_APP
  [cdp1]=$CDP_1
  [cdp2]=$CDP_2
  [cdp3]=$CDP_3
  [cdpmaster]=$CDP_MASTER
  [github]=$PROJECT_ROME_GITHUB
  [pingpong]=$CDP_PINGPONG
  [os]=$MS_OS
  [cdp2os]=$CDP2OS
  [mmx]=$MMX
  [bash]=$BASH
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
  [sign_in]="$MY_HOME_WIN/one_rome_sign_in.py"
  [gradle]="$MY_HOME_WIN/gradle.py"
  [adb]="$MY_HOME_WIN/adb_android/adb_android/adb_android.py"
  [adb_commands]="$MY_HOME_WIN/adb_commands.py"
)

#### Functions ####

_set_dir() { _execute_func work_dir_funcs $1; }

_navigate() { _execute $1 nav_keys $2; }

# Open a explorer window at the path name - op = OPen
op() { _navigate cygstart $1; }

# Change directory to path name - gt = GO to
go() { _navigate cd $1; _set_dir $1; }

# Check Script
cs() { _execute "$SUBL_FUNC" script_keys $1; }