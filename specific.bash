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
  [notes]=$NOTES
  [bugs]=$BUG_FILES
  [home]=$MY_HOME
  # Enlistment
  [en]=$MY_ENLISTMENT
  [en_cdp]=$ENLISTMENT_CDP
  [en_appservice]=$ENLISTMENT_APP_CONTRACT
  # CDP
  [scripts]=$SCRIPTS
)

declare -A script_keys=(
  # Windows
  [vm]="$VM_SETTINGS/aliases.pub"
  [cmd]="$CMD_SETTINGS/aliases.pub"
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

#### Restoring CDP Secrets ####

_cp_secret () { my_dir=`cat "$1"` && cp -r "$2" $my_dir; }

_cp_secrets_1 () { _cp_secret "$1\path.txt" "$1\Secrets.java"; }
_cp_secrets_2 () { _cp_secret "$1\path.txt" "$1\gradle.properties"; }
_cp_secrets_3 () { _cp_secret "$1\path.txt" "$1\Secrets.java"; }
_cp_secrets_4 () { _cp_secret "$1\path.txt" "$1\Secrets.cs"; }

cp_secrets () { _cp_secrets_1 "$CDP_ROME_SECRET"; _cp_secrets_2 "$CDP_ROME_IN_SECRET"; _cp_secrets_3 "$GITHUB_ROME_SECRET"; _cp_secrets_4 "$XAM_SECRET"; }

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

#### Clearing / Moving build files ####

clean_android () { rm -rf "$CDP_1/core/android/build" && rm -rf "$CDP_1/sdk/android/build" && rm -rf "$CDP_1/samples/CDPHost/android/app/build" && rm -rf "$CDP_1/samples/romanapp/android/internal/build";  }

clean_cdphost () { rm -rf "$CDP_1/samples/CDPHost/android/app/build";  }

clean_coa () { rm -rf "$COA/DSS/AuthLib/build"; }

#### Download VM - Private Functions ####

# Print and go to the latest build directory with a VHD
_vm () { for var in {1..10}; do cd $1; ls | sort | tail -$var | head -1; cd `ls | sort | tail -$var | head -1`; if [ -d "$1/vhd/"]; then echo "$var : $1 exists"; break; fi; done; }

# After using `_vm` to navigate to the directory, copy the VHD to local drive
_cpvm() { rsync -a --progress $1/vhd/vhd_client_enterprise_en-us_vl/* $C/VHDs/; }

# After using `_vm` to navigate to the directory, copy the sfpcopy to local drive
_cpsfp() { rsync -a --progress $1/bin/idw/sfpcopy.exe $C/VHDs/; }

# Print and go to the latest build directory with a VHD containing a sfpcopy
_sfp () { for var in {1..10}; do cd $VM_DIR; ls | sort | tail -$var | head -1; cd `ls | sort | tail -$var | head -1`; if [ -d "$1/bin/idw/sfpcopy.exe" ]; then echo "$var : sfpcopy.exe exists"; break; fi; done; }

_64 () { $1 "amd64fre"; }

_86 () { $1 "x86fre"; }

#### Download VM - Public Functions ####

# go to the latest build directory
latest () { cd $VM_DIR; ls | sort | tail -1; cd `ls | sort | tail -1`; }

# go to the $1th latest build directory
vmn () { cd $VM_DIR; ls | sort | tail -$1 | head -1; cd `ls | sort | tail -$1 | head -1`; }

vm () { _64 _vm $VM_DIR; }
vm86 () { _86 _vm $VM_DIR; }

vm_release () { _64 _vm $RELEASE_VM_DIR; }
vm86_release () { _86 _vm $RELEASE_VM_DIR; }

cpvm () { _64 _cpvm; }
cpvm86 () { _86 _cpvm; }

cpsfp () { _64 _cpsfp; }
cpsfp86 () { _86 _cpsfp; }

sfp () { _64 _sfp; }
# Note: Disabled due to broken
# sfp86 () { _86 _sfp; }