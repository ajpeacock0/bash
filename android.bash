#### Constants ####

CDP1="\\\\DESKTOP-5MMAKOD"
CDP2="\\\\DESKTOP-4HQ4UEA"
MASTER="\\\\DESKTOP-CTKCQFE"
RS1="\\\\DESKTOP-KDTTPVC"
OFFICIAL="\\\\DESKTOP-NM3ECF2"
LAPTOP="\\\\DESKTOP-02BI2KL"
DEVBOX="$C_WIN\\Windows\\ServiceProfiles\\LocalService\\AppData\\Local"

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

DDR_LOC="$WORK/stored_logs"
COA_BUILDS="$WORK/bug_files/coa_builds"

GRADLEW="$CDP_1/gradlew"

declare -A app_keys=(
  [cdphost]=$CDP_HOST
  [coa]=$CORTANA
  [tdd]=$TDDRUNNER
  [rome]=$ROMAN_APP
  [rome_in]=$ROMAN_APP_IN
  [xamarin]=$XAMARIN_APP
)

declare -A app_name_keys=(
  [cdphost]=$CDP_HOST_NAME
  [coa]=$CORTANA_NAME
  [tdd]=$TDDRUNNER_NAME
  [rome]=$ROMAN_APP_NAME
  [rome_in]=$ROMAN_APP_IN_NAME
  [xamarin]=$XAMARIN_APP_NAME
)

declare -A build_keys=(
  [1p]="sdk_1p:assembleDebug"
  [1p_release]="sdk_1p:assembleRelease"
  [3p]="sdk_3p:assembleDebug"
  [3p_release]="sdk_3p:assembleRelease"
  [rome]="romanAppInternal:assembleDebug"
  [rome_release]="romanAppInternal:assembleRelease"
)

declare -A machine_keys=(
  [cdp1]=$CDP1
  [cdp2]=$CDP2
  [master]=$MASTER
  [rs1]=$RS1
  [official]=$OFFICIAL
  [laptop]=$LAPTOP
  [devbox]=$DEVBOX
)

#### Android Viewing + Interaction - Private Functions ####

_app_rm_log () { $ADB shell rm $1/CDPTraces.log; }

_app_pull_log () { $ADB pull $1/CDPTraces.log CDPTraces_android.log; }

_app_pull_dir () { $ADB pull $1 ConnectedDevicesPlatform_android; }

_app_stop () { $ADB shell am force-stop $1; }

_app_nuke () { $ADB shell pm clear $1; }

#### Android Viewing + Interaction - Public Functions ####

ls_devices () { $ADB devices | grep "device$" | sed 's/ *device//g'; }

ls_device () { $ADB devices | grep "device$" | sed 's/ *device//g' | sed -n "$1"p; }

ls_apps () { $ADB ls sdcard/Android/data/; }

# Delete the CDP log for the given app
rm_log () { _execute _app_rm_log app_keys $1; }

# Pull the CDP log for the given app
pull_log () { _execute _app_pull_log app_keys $1; }

# Pull the ConnectedDevicesPlatform directory for the given app
pull_dir () { _execute _app_pull_dir app_keys $1; }

# Close given application
stop () { _execute _app_stop app_name_keys $1; }

# Close app process and clear out all the stored data for given that app
nuke () { _execute _app_nuke app_name_keys $1; }

#### Storing Logs - Private Functions ####

# Generate Date Time Stamp
_dts() { date +%Y-%m-%d-%H-%M-%S; }

# Create a directory with timestamp
_dmkdir() { DDIR="$DDR_LOC/$(_dts)"; mkdir $DDIR && return 0; }

# Copy the CDPTraces.log from the given machine
_copy_log_internal () { cp "$1\ConnectedDevicesPlatform\CDPTraces.log" "CDPTraces_PC.log"; }

_copy_log () { _execute _copy_log_internal machine_keys $1 && return 0; }

_mvlog () { mv $1.log "$DDIR\\$1.log" && return 0; }

#### Storing Logs - Public Functions ####

# $1: Name of VM/PC which has a shared directory containing CDPTraces.log
store_log () { _copy_log $1 && _dmkdir && _mvlog "CDPTraces_PC" && cd "$DDIR" && exp; }

# Pull the log to the given application and given desktop directory log to a timestamp directory e.g. store_coa $CDP1_VM
# $1: Name of application to pull from
# $2: [Optional] Name of VM/PC which has a shared directory containing CDPTraces.log
store () { pull_log $1 && _dmkdir && _mvlog "CDPTraces_android" && cd "$DDIR" && exp && if [ $# -eq 2 ]; then $(_copy_log $2); fi; }

#### Building Android - Private Functions ####

_gradlew () { cd $CDP_1 && dos2unix gradlew && $GRADLEW $1; }

#### Building Android - Public Functions ####

build() { _execute _gradlew build_keys $1; }

deploy_3p () { $SCRIPTS/Deploy-Android-3p-SDK.cmd -iteration 1703 -network; }

package_3p () { build_3p && build_rome_release && deploy_3p; }

#### TDD commands ####

# Run TDD on Android with the input. If $2 is set, use it, otherwise pass 1
tdd_run () { repeat=${2-1}; $ADB shell am start -S -n $TDDRUNNER_NAME/.TddRunner --es name $1 --ei repeat $repeat; }

# Run TDD on Android with the input in debug mode. If $2 is set, use it, otherwise pass 1
tdd_run_deb () { repeat=${2-1}; $ADB shell am start -S -D -n $TDDRUNNER_NAME/.TddRunner --es name $1 --ei repeat $repeat; }