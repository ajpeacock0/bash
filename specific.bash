#### ENV VARS ####

# Enlistment directories
ENLISTMENT_CDP="$F/enlistments/onecoreuap/windows/cdp"
ENLISTMENT_APP_CONTRACT="$F/enlistments/onecoreuap/base/appmodel/AppContracts"

# Git Repo locations of importanace
COA="$GIT_REPOS/CortanaAndroid"
TDD="$CDP_1/build/onecorefast/x64/debug/tests"
ROME_APP="$CDP_1/samples/romanapp/android"
ROME_IN_APK="$CDP_1/samples/romanapp/android/internal/build/outputs/apk"
XAMARIN_APP="$CDP_1/samples/xamarinsample"
XAMARIN_PROJ="$CDP_1/sdk/xamarin"

# APK locations
XAMARIN_APK="$XAMARIN_APP/ConnectedDevices.Xamarin.Droid.Sample/bin/"
ROME_IN_APK="$ROME_APP/internal/build/outputs/apk"
SDK_3P_AAR="$CDP_1/sdk/android/3p/build/outputs/aar"
XAMARIN_DLL="$XAMARIN_PROJ/ConnectedDevices.Xamarin.Droid/bin"

# Network directories
VM_DIR="//winbuilds/release/RS_ONECORE_DEP_ACI/"
RELEASE_VM_DIR="//winbuilds/release/RS2_RELEASE/"
ANPEA_DIR="//redmond/osg/release/DEP/CDP/anpea"
ROME_DROP="//redmond/osg/release/dep/CDP/V3Partners"
CURRENT_ROME_DROP="$ROME_DROP/Rome_1703"


# Note files directories
NOTES="$C/notes/"
BUG_FILES="$WORK/bug_files"

VM_SETTINGS="$WORK_WIN/vm_settings"
CMD_SETTINGS="$WORK_WIN/cmd.exe_settings"

# Secret
SECRET_HOME="D:\work_files\Secrets"
CDP_ROME_SECRET="$SECRET_HOME\cdp_rome"
GITHUB_ROME_SECRET="$SECRET_HOME\github_rome"
XAM_SECRET="$SECRET_HOME\Xamarin"

# Application directories
MY_JAVA_HOME="$C/Program\ Files/Java/jdk1.8.0_121"
JAVAC="$MY_JAVA_HOME/bin/javac.exe"
JAVAP="$MY_JAVA_HOME/bin/javap.exe"
JAVAH="$MY_JAVA_HOME/bin/javah.exe"
VS="$C/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio\ 14.0/Common7/IDE/devenv.exe"
NUGET="$C/tools/NuGet/nuget.exe"
CMAKE="$C/Users/anpea/AppData/Local/Android/sdk/cmake/3.6.3155560/bin/cmake.exe"

# Local log directories
SYS_CDP_WIN="\"$C_WIN\\Windows\\ServiceProfiles\\LocalService\\AppData\\Local\\ConnectedDevicesPlatform\""
USER_CDP_WIN="\"$C_WIN\\Users\\anpea\\AppData\\Local\\ConnectedDevicesPlatform\""

SYS_CDP="$C/Windows/ServiceProfiles/LocalService/AppData/Local/ConnectedDevicesPlatform"
USER_CDP="$C/Users/anpea/AppData/Local/ConnectedDevicesPlatform"

declare -A nav_keys=(
  # Build files
  [xam_apk]=$XAMARIN_APK
  [xam_dll]=$XAMARIN_DLL
  [sdk_aar]=$SDK_3P_AAR
  [rome_apk]=$ROME_IN_APK
  # System logs
  [cdpsvc]=$SYS_CDP
  [cdpusersvc]=$USER_CDP
  # Network
  [anpea_dir]=$ANPEA_DIR
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
  [project-rome]="$GIT_REPOS/project-rome/project-rome-for-android-(preview-release)"
  [pingpong]="$GIT_REPOS/CDPPingPong"
  # notes
  [work]=$WORK
  [notes]=$NOTES
  [bugs]=$BUG_FILES
  [home]=$CYGWIN
  # Enlistment
  [en]="$F/enlistments"
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
  [inputrc]="$CYGWIN_WIN/.inputrc_custom"
  [android]="$CYGWIN_WIN/android.bash"
  [general]="$CYGWIN_WIN/general.bash"
  [git]="$CYGWIN_WIN/git.bash"
  [main]="$CYGWIN_WIN/main.bash"
  [shared]="$CYGWIN_WIN/shared.bash"
  [specific]="$CYGWIN_WIN/specific.bash"
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
alias javac="$JAVAC"
alias javap="$JAVAP"
alias javah="$JAVAH"
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
_cp_secrets_2 () { _cp_secret "$1\path.txt" "$1\Secrets.java"; }
_cp_secrets_3 () { _cp_secret "$1\path.txt" "$1\Secrets.cs"; }

cp_secrets () { _cp_secrets_1 "$CDP_ROME_SECRET" && _cp_secrets_2 "$GITHUB_ROME_SECRET" && _cp_secrets_3 "$XAM_SECRET"; }

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