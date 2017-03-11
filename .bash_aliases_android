#### Constants ####

# PC + VM Names used for `store_<specific>` commands
CDP1="\\\\DESKTOP-5MMAKOD"; export CDP1_VM
CDP2="\\\\DESKTOP-4HQ4UEA"; export CDP2_VM
MASTER="\\\\DESKTOP-CTKCQFE"; export MASTER_VM
RS1="\\\\DESKTOP-KDTTPVC"; export RS1_VM
OFFICIAL="\\\\DESKTOP-NM3ECF2"; export OFFICIAL_VM
LAPTOP="\\\\DESKTOP-02BI2KL"; export LAPTOP
DEVBOX="C:\\Windows\\ServiceProfiles\\LocalService\\AppData\\Local"; export DEVBOX

CDP_HOST_NAME="com.microsoft.cdp.CDPHost"
CORTANA_NAME="com.microsoft.cortana"
TDDRUNNER_NAME="com.microsoft.tddrunner"
ROMAN_APP_NAME="com.microsoft.romanapp"
ROMAN_APP_IN_NAME="com.microsoft.romanappinternal"
XAMARIN_APP_NAME="ConnectedDevices.Xamarin"

APP_DIR="sdcard/Android/data"

CDP_HOST="$APP_DIR/$CDP_HOST_NAME/files"
CORTANA="$APP_DIR/$CORTANA_NAME/files"
TDDRUNNER="$APP_DIR/$TDDRUNNER_NAME/files"
ROMAN_APP="$APP_DIR/$ROMAN_APP_NAME/files"
ROMAN_APP_IN="$APP_DIR/$ROMAN_APP_IN_NAME/files"
XAMARIN_APP="$APP_DIR/$XAMARIN_APP_NAME/files"

DDR_LOC="$WORK/bug_files/CoA_testing"
COA_BUILDS="$WORK/bug_files/coa_builds"

#### Android Viewing + Interaction - Private Functions ####

# Delete the CDP log
_app_rm_log () { $ADB shell rm $1/CDPTraces.log; }

# Pull the CDP log
_app_pull_log () { $ADB pull $1/CDPTraces.log CDPTraces.log; }

# Close application
_app_stop () { adb shell am force-stop $1; }

# Close app process and clear out all the stored data for that app.
_app_nuke () { adb shell pm clear $1; }

#### Android Viewing + Interaction - Public Functions ####

ls_devices () { adb devices | grep "device$" | sed 's/ *device//g'; }

ls_device () { adb devices | grep "device$" | sed 's/ *device//g' | sed -n "$1"p; }

# CDP Host commands
cdphost_rm_log () { _app_rm_log $CDP_HOST; }
cdphost_pull_log () { _app_pull_log $CDP_HOST; }
cdphost_stop () { _app_stop $CDP_HOST_NAME; }
cdphost_nuke () { _app_nuke $CDP_HOST_NAME; }

# CoA commands
coa_rm_log () { _app_rm_log $CORTANA; }
coa_pull_log () { _app_pull_log $CORTANA; }
coa_stop () { _app_stop $CORTANA_NAME; }
coa_nuke () { _app_nuke $CORTANA_NAME; }

# TddRunner commands
tdd_rm_log () { _app_rm_log $TDDRUNNER; }
tdd_pull_log () { _app_pull_log $TDDRUNNER; }
tdd_stop () { _app_stop $TDDRUNNER_NAME; }
tdd_nuke () { _app_nuke $TDDRUNNER_NAME; }

# RomanApp commands
rome_rm_log () { _app_rm_log $ROMAN_APP; }
rome_pull_log () { _app_pull_log $ROMAN_APP; }
rome_stop () { _app_stop $ROMAN_APP_NAME; }
rome_nuke () { _app_nuke $ROMAN_APP_NAME; }

# RomanApp Internal commands
rome_in_rm_log () { _app_rm_log $ROMAN_APP_IN; }
rome_in_pull_log () { _app_pull_log $ROMAN_APP_IN; }
rome_in_stop () { _app_stop $ROMAN_APP_IN_NAME; }
rome_in_nuke () { _app_nuke $ROMAN_APP_IN_NAME; }

# Xamarin Sample commands
xamarin_rm_log () { _app_rm_log $XAMARIN_APP; }
xamarin_pull_log () { _app_pull_log $XAMARIN_APP; }
xamarin_stop () { _app_stop $XAMARIN_APP_NAME; }
xamarin_nuke () { _app_nuke $XAMARIN_APP_NAME; }

#### Storing Logs - Private Functions ####

# Macro style for requiring 1 or more arguments
_REQUIRE_ARGS () { if [ $# -eq 0 ]; then echo "No arguments provided"; return; fi; }

# Generate Date Time Stamp
_dts() { date +%Y-%m-%d-%H-%M-%S; }

# Create a directory with timestamp
_dmkdir() { DDIR="$DDR_LOC/$(_dts)"; export DDIR; mkdir $DDIR; }

# Store the 
_store_log () { cp "$1\ConnectedDevicesPlatform\CDPTraces.log" "$DDIR\CDPTraces_PC.log"; }

# Pull the log to the given application and given desktop directory log to a timestamp directory e.g. store_coa $CDP1_VM
# $1: Function which will pull the CDPTraces.log from a android application
# $2: [Optional] Name of VM/PC which has a shared directory containing CDPTraces.log
_store () { _REQUIRE_ARGS $@; $1 && _dmkdir && mv CDPTraces.log "$DDIR\CDPTraces_android.log"; if [ $# -eq 1 ]; then cd "$DDIR"; else $(_store_log $2) && cd "$DDIR"; fi; }

#### Storing Logs - Public Functions ####

# $1: Name of VM/PC which has a shared directory containing CDPTraces.log
store_log () { _REQUIRE_ARGS $@; _dmkdir && $(_store_log $1) && cd "$DDIR"; }

# $1: [Optional] Name of VM/PC which has a shared directory containing CDPTraces.log. This will be stored with the Android log
store_coa () { $(_store coa_pull_log $@); }
store_rome () { $(_store rome_pull_log $@); }
store_rome_in () { $(_store rome_in_pull_log $@); }
store_cdphost () { $(_store cdphost_pull_log $@); }

#### TDD commands ####

# Run TDD on Android with the input. If $2 is set, use it, otherwise pass 1
tdd_run () { repeat=${2-1}; adb shell am start -S -n $TDDRUNNER_NAME/.TddRunner --es name $1 --ei repeat $repeat; }

# Run TDD on Android with the input in debug mode. If $2 is set, use it, otherwise pass 1
tdd_run_deb () { repeat=${2-1}; adb shell am start -S -D -n $TDDRUNNER_NAME/.TddRunner --es name $1 --ei repeat $repeat; }
