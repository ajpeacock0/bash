#### Constants ####

# PC + VM Names used for `store_<specific>` commands
CDP1="\\\\DESKTOP-5MMAKOD"; export CDP1_VM
CDP2="\\\\DESKTOP-4HQ4UEA"; export CDP2_VM
MASTER="\\\\DESKTOP-CTKCQFE"; export MASTER_VM
RS1="\\\\DESKTOP-KDTTPVC"; export RS1_VM
OFFICIAL="\\\\DESKTOP-NM3ECF2"; export OFFICIAL_VM
LAPTOP="\\\\DESKTOP-02BI2KL"; export LAPTOP
DEVBOX="$C_WIN\\Windows\\ServiceProfiles\\LocalService\\AppData\\Local"; export DEVBOX

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

APP_NAMES="\n\
- cdphost\n\
- coa\n\
- tdd\n\
- rome\n\
- rome_in\n\
- xamarin\n\
"

BUILD_TYPES="\n\
- 3p\n\
- rome\n\
- rome_release\n\
"

#### Android Viewing + Interaction - Private Functions ####

_app_rm_log () { $ADB shell rm $1/CDPTraces.log; }

_app_pull_log () { $ADB pull $1/CDPTraces.log CDPTraces_android.log; }

_app_pull_dir () { $ADB pull $1 ConnectedDevicesPlatform_android; }

_app_stop () { $ADB shell am force-stop $1; }

_app_nuke () { $ADB shell pm clear $1; }

_exe_app()
{
    case $1 in
        cdphost)  $2 $CDP_HOST && return 0;;
        coa)      $2 $CORTANA && return 0;;
        tdd)      $2 $TDDRUNNER && return 0;;
        rome)     $2 $ROMAN_APP && return 0;;
        rome_in)  $2 $ROMAN_APP_IN && return 0;;
        xamarin)  $2 $XAMARIN_APP && return 0;;
        * ) printf "Valid options are $APP_NAMES" && return 1;;
    esac
}

_exe_app_name()
{
    case $1 in
        cdphost)  $2 $CDP_HOST_NAME && return 0;;
        coa)      $2 $CORTANA_NAME && return 0;;
        tdd)      $2 $TDDRUNNER_NAME && return 0;;
        rome)     $2 $ROMAN_APP_NAME && return 0;;
        rome_in)  $2 $ROMAN_APP_IN_NAME && return 0;;
        xamarin)  $2 $XAMARIN_APP_NAME && return 0;;
        * ) printf "Valid options are $APP_NAMES" && return 1;;
    esac
}

#### Android Viewing + Interaction - Public Functions ####

ls_devices () { $ADB devices | grep "device$" | sed 's/ *device//g'; }

ls_device () { $ADB devices | grep "device$" | sed 's/ *device//g' | sed -n "$1"p; }

ls_apps () { $ADB ls sdcard/Android/data/; }

# Delete the CDP log for the given app
rm_log () { _exe_app $1 _app_rm_log; }

# Pull the CDP log for the given app
pull_log () { _exe_app $1 _app_pull_log; }

# Pull the ConnectedDevicesPlatform directory for the given app
pull_dir () { _exe_app $1 _app_pull_dir; }

# Close given application
stop () { _exe_app_name $1 _app_stop; }

# Close app process and clear out all the stored data for given that app
nuke () { _exe_app_name $1 _app_nuke; }

#### Storing Logs - Private Functions ####

# Macro style for requiring at least 1 argument
_REQUIRE_ARGS () { if [ $# -eq 0 ]; then echo "No arguments provided"; return 1; fi; return 0; }

# Generate Date Time Stamp
_dts() { date +%Y-%m-%d-%H-%M-%S; }

# Create a directory with timestamp
_dmkdir() { DDIR="$DDR_LOC/$(_dts)"; mkdir $DDIR && cd $DDIR && exp && return 0; }

# Copy the CDPTraces.log from the given machine
_copy_log () { cp "$1\ConnectedDevicesPlatform\CDPTraces.log" "CDPTraces_PC.log"; }

# Pull the log to the given application and given desktop directory log to a timestamp directory e.g. store_coa $CDP1_VM
_store () { $1 $2 && _dmkdir && mv CDPTraces_android.log "$DDIR\CDPTraces_android.log" && if [ $# -eq 2 ]; then cd "$DDIR"; else $(_copy_log $3) && cd "$DDIR"; fi; }

#### Storing Logs - Public Functions ####

# $1: Name of VM/PC which has a shared directory containing CDPTraces.log
store_log () { _REQUIRE_ARGS $@ && _dmkdir && $(_copy_log $1); }

# $1: Name of application to pull from
# $2: [Optional] Name of VM/PC which has a shared directory containing CDPTraces.log
store() { _REQUIRE_ARGS $@ && _store pull_log $@; }

#### Building Android ####

_gradlew () { cd $CDP_1 && $GRADLEW $1; }

build()
{
    case $1 in
        3p)           _gradlew sdk_3p:assembleRelease sdk_3p:assembleDebug && return 0;;
        rome)         _gradlew romanAppInternal:assembleDebug && return 0;;
        rome_release) _gradlew romanAppInternal:assembleRelease && return 0;;
        * ) printf "Valid options are $BUILD_TYPES" && return 1;;
    esac
}

deploy_3p () { $SCRIPTS/Deploy-Android-3p-SDK.cmd -iteration 1703 -network; }

package_3p () { build_3p && build_rome_release && deploy_3p; }

#### TDD commands ####

# Run TDD on Android with the input. If $2 is set, use it, otherwise pass 1
tdd_run () { repeat=${2-1}; $ADB shell am start -S -n $TDDRUNNER_NAME/.TddRunner --es name $1 --ei repeat $repeat; }

# Run TDD on Android with the input in debug mode. If $2 is set, use it, otherwise pass 1
tdd_run_deb () { repeat=${2-1}; $ADB shell am start -S -D -n $TDDRUNNER_NAME/.TddRunner --es name $1 --ei repeat $repeat; }