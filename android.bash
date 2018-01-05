#### Key Declarations ####

set_android_arrays()
{
    declare -g -A install_keys=(
        # OneRomanApp
        [one_rome]=$ONE_ROME_APK
        # [one_rome_release]=$TODO
        [one_rome_x86]=$ROME_IN_APK_X86
        # [one_rome_x86_release]=$TODO
        # Xamarin RomanApp
        [xam]=$XAMARIN_APP_APK
        [xam_release]=$XAMARIN_APP_RELEASE_APK
        # [xam_x86]=$TODO
        # [xam_x86_release]=$TODO
        # CDPHost
        [cdphost]=$CDP_HOST_APK
        # [cdphost_release]=$TODO
        [cdphost_x86]=$CDP_HOST_APK_X86
        # [cdphost_x86_release]=$TODO
        # TDD Runner
        [tdd]=$TDD_RUNNER_APK
        # [tdd_release]=$TODO
        [tdd_x86]=$TDD_RUNNER_APK_X86
        # [tdd_x86_release]=$TODO
    )

    declare -g -A clean_keys=(
        # First Party SDK - DEPRECIATED
        [3p]="$CURR_CDP/sdk/android/3p/build" 
        # Xamarin SDK
        [xam_sdk]="$XAMARIN_PROJ/ConnectedDevices.Xamarin.Droid/bin"
        # OneRomanApp
        [one_rome]="$CURR_CDP/samples/oneromanapp/android/app/build"
        [one_rome_release]="$CURR_CDP/samples/oneromanapp/android/app/build"
        [one_rome_x86]="$CURR_CDP/samples/oneromanapp/android/app/build"
        [one_rome_x86_release]="$CURR_CDP/samples/oneromanapp/android/app/build"
        # Xamarin RomanApp
        [xam]="$XAMARIN_APP_DIR/ConnectedDevices.Xamarin.Droid.Sample/bin $XAMARIN_APP_DIR/ConnectedDevices.Xamarin.Droid.Sample/obj"
        [xam_release]="$XAMARIN_PROJ/ConnectedDevices.Xamarin.Droid/bin"
        [xam_x86]=$XAMARIN_APP
        [xam_x86_release]=$XAMARIN_APP
        # CDPHost
        [cdphost]="$CURR_CDP/samples/CDPHost/android/app/build" 
        [cdphost_release]="$CURR_CDP/samples/CDPHost/android/app/build" 
        [cdphost_x86]="$CURR_CDP/samples/CDPHost/android/app/build" 
        [cdphost_x86_release]="$CURR_CDP/samples/CDPHost/android/app/build" 
        # TDD Runner
        [tdd]="$CURR_CDP/test/tdd/runners/android/app/build"
        [tdd_release]="$CURR_CDP/test/tdd/runners/android/app/build"
        [tdd_x86]="$CURR_CDP/test/tdd/runners/android/app/build"
        [tdd_x86_release]="$CURR_CDP/test/tdd/runners/android/app/build"
    )

    declare -g -A xam_keys=(
        [dll]="/t:Rebuild /p:Configuration=Debug $XAM_DLL_CSPROJ"
        [dll_release]="/t:Rebuild /p:Configuration=Release $XAM_DLL_CSPROJ"
        # Without SignAndroidPackage no APK is generated
        [app]="/t:Rebuild /t:SignAndroidPackage /p:Configuration=Debug $XAM_APP_CSPROJ"
        [app_release]="/t:Rebuild /t:SignAndroidPackage /p:Configuration=Release $XAM_APP_CSPROJ"
    )

    declare -g -A sign_input_keys=(
        [app]=$XAMARIN_APK_WIN/Debug/com.microsoft.romanapp.xamarin
    )

    declare -g -A machine_keys=(
        [cdp1]=$CDP1
        [cdp2]=$CDP2
        [master]=$MASTER
        [rs1]=$RS1
        [official]=$OFFICIAL
        [laptop]=$LAPTOP
        [devbox]=$DEVBOX
    )



    declare -g -A adb_device_keys=(
        [vm]=-e
        [usb]=-d
    )
}

set_android_arrays

#### Python script aliases ####

# ADB Commands shortcut
ac () { python $MY_HOME_WIN\\adb_commands.py $@; }

# View logcat though a better view - https://github.com/JakeWharton/pidcat
logcat () { python "$D_WIN\git_repos\pidcat\pidcat.py" $@; }

os_version() { python $MY_HOME_WIN\\adb_commands.py os_version; }

# Using gradle, builds the given task
build() { python $MY_HOME_WIN\\build.py --root_dir="$CURR_CDP_WIN" $@; }

# Install the app's APK using ADB
adb_in() { python $MY_HOME_WIN\\adb_commands.py install --root_dir="$CURR_CDP_WIN" --launch $@; }

# Uninstall the app's APK using ADB
adb_un () { python $MY_HOME_WIN\\adb_commands.py uninstall $@; }

adb_restart () { python $MY_HOME_WIN\\adb_commands.py restart; }

# Build gradle task
build() { python $MY_HOME_WIN\\build.py --root_dir="$CURR_CDP_WIN" $@; }

# Run the givne TDD tests
tdd_run() { python $MY_HOME_WIN\\adb_commands.py tdd --tests $@; }

#### Python script aliases ####

_set_adb_device () { ADB_DEVICE=$1; }

_choose_adb_device () { _execute_opt _set_adb_device adb_device_keys $1; }

#### Android Viewing + Interaction - Private Functions ####

_adb_run ()
{
    if [[ -v ADB_DEVICE ]]
    then
        echo "Running adb on device $ADB_DEVICE ([vm]=-e [usb]=-d)"
        "$ADB" $ADB_DEVICE "$@"
    else 
        echo "Running adb on only connected device"
        "$ADB" "$@"
    fi
}

_adb_root () { _adb_run root; }

_adb_shell () { _adb_run shell "$@"; }

_adb_swipe () { _adb_shell input swipe 200 900 200 100 100; }

_adb_power () { _adb_shell input keyevent 26; }

_adb_input_text () { _adb_shell input text "$1"; }

_adb_back () { _adb_shell input keyevent 3; }

_adb_ok () { _adb_shell input keyevent 66; }

_adb_tab () { _adb_shell input keyevent 61; }

#### Android Viewing + Interaction - Public Functions ####

adb_on () { _choose_adb_device $1 && _adb_power && _adb_swipe; }

adb_off () { _choose_adb_device $1 && _adb_power; }

adb_connect () { adb_restart && adb connect "$HOME_IP:$HOME_PORT" && adb devices; }

adb_disconnect () { adb disconnect "$HOME_IP:$HOME_PORT" && adb devices; }

#### Storing Files - Private Functions ####

# Generate Date Time Stamp
_dts() { date +%Y-%m-%d-%H-%M-%S; }

# Create a directory with timestamp
_dmkdir() { DDIR="$1/$(_dts)"; mkdir $DDIR && return 0; }

_dmkdir_log() { _dmkdir "$LOG_DUMP_DIR" && return 0; }

_dmkdir_apk() { _dmkdir "$APK_DIR" && return 0; }

# Copy the CDPTraces.log from the given machine
_copy_log_internal () { cp "$1\ConnectedDevicesPlatform\CDPTraces.log" "CDPTraces_PC.log"; }

_copy_log () { _execute _copy_log_internal machine_keys $1 && return 0; }

_mvlog () { mv $1.log "$DDIR\\$1.log" && return 0; }

_store_apk() { _dmkdir_apk && cp "$1" "$DDIR" && cd "$DDIR" && exp; }

_clean () {  rm -rf $1; }

#### Storing/Cleaning Files - Public Functions ####

# $1: Name of VM/PC which has a shared directory containing CDPTraces.log
store_log () { _copy_log $1 && _dmkdir_log && _mvlog "CDPTraces_PC" && cd "$DDIR" && exp; }

# Pull the log to the given application and given desktop directory log to a timestamp directory e.g. store_coa $CDP1_VM
# $1: Name of application to pull from
# $2: [Optional] Name of VM/PC which has a shared directory containing CDPTraces.log
store () { pull_log $1 && _dmkdir_log && _mvlog "CDPTraces_android" && cd "$DDIR" && exp && if [ $# -eq 2 ]; then $(_copy_log $2); fi; }

store_apk() { _choose_adb_device $2 && _execute _store_apk install_keys $1; }

# Removes all files under build dirs
clean() { _execute _clean clean_keys $1; }

#### Building Android - Private Functions ####

_javap () { javap -classpath $CLASSES_JAR "com.microsoft.connecteddevices.$1"; }

#### Building Android - Public Functions ####

build_in() { build $1 && adb_in $@; }

#### TDD commands ####

tdd_files () { _choose_adb_device $1 && _adb_shell ls /data/user/0/$TDDRUNNER_NAME/files/trx; }

tdd_pull () { _choose_adb_device $1 && _adb_root; _adb_run pull /data/user/0/$TDDRUNNER_NAME/files/trx && _adb_run pull /data/user/0/$TDDRUNNER_NAME/files/logcat_dump; }

tdd_in_run() { adb_in tdd && tdd_run $1 ${@:2}; }