#### Key Declarations ####

declare -A app_keys=(
    [cdphost]=$CDP_HOST
    [coa]=$CORTANA
    [tdd]=$TDDRUNNER
    [rome_ex]=$ROMAN_APP
    [rome_in]=$ROMAN_APP_IN
    [xam]=$XAMARIN_APP
)

declare -A app_name_keys=(
    [cdphost]=$CDP_HOST_NAME
    [coa]=$CORTANA_NAME
    [tdd]=$TDDRUNNER_NAME
    [rome_ex]=$ROMAN_APP_NAME
    [rome_in]=$ROMAN_APP_IN_NAME
    [xam]=$XAMARIN_APP_NAME
    # Because this is also used for install
    [rome_in_x86]=$ROMAN_APP_IN_NAME
    [cdphost_x86]=$CDP_HOST_NAME
    [tdd_x86]=$TDDRUNNER_NAME
)

declare -A build_keys=(
    [1p]="sdk_1p:assembleDebug"
    [1p_release]="sdk_1p:assembleRelease"
    [3p]="sdk_3p:assembleDebug"
    [3p_release]="sdk_3p:assembleRelease"
    [converged]="sdk_converged:assembleDebug"
    [converged_release]="sdk_converged:assembleRelease"
    [rome_in]="romanAppInternal:assembleDebug"
    [rome_in_release]="romanAppInternal:assembleRelease"
    [rome_ex]=":romanApp:assembleDebug"
    [rome_ex_release]=":romanApp:assembleRelease"
    [wnsping]=":wnspingtest:assembleDebug"
    [wnsping_release]=":wnspingtest:assembleRelease"
    [cdphost]="cdphost:assembleDebug"
    [cdphost_release]="cdphost:assembleRelease"
    [tdd]="tdd:assembleDebug"
    [tdd_release]="tdd:assembleRelease"
    [conv]="sdk_converged:assembleDebug"
    [conv_release]="sdk_converged:assembleRelease"
    # x86 versions
    [1p_x86]="sdk_1p:assembleDebug -PabiToBuild=x86"
    [1p_release_x86]="sdk_1p:assembleRelease -PabiToBuild=x86"
    [3p_x86]="sdk_3p:assembleDebug -PabiToBuild=x86"
    [3p_release_x86]="sdk_3p:assembleRelease -PabiToBuild=x86"
    [converged_x86]="sdk_converged:assembleDebug -PabiToBuild=x86"
    [converged_release_x86]="sdk_converged:assembleRelease -PabiToBuild=x86"
    [rome_in_x86]="romanAppInternal:assembleDebug -PabiToBuild=x86"
    [rome_in_release_x86]="romanAppInternal:assembleRelease -PabiToBuild=x86"
    [rome_ex_x86]=":romanApp:assembleDebug -PabiToBuild=x86"
    [rome_ex_release_x86]=":romanApp:assembleRelease -PabiToBuild=x86"
    [wnsping_x86]=":wnspingtest:assembleDebug -PabiToBuild=x86"
    [wnsping_release_x86]=":wnspingtest:assembleRelease -PabiToBuild=x86"
    [cdphost_x86]="cdphost:assembleDebug -PabiToBuild=x86"
    [cdphost_release_x86]="cdphost:assembleRelease -PabiToBuild=x86"
    [tdd_x86]="tdd:assembleDebug -PabiToBuild=x86"
    [tdd_release_x86]="tdd:assembleRelease -PabiToBuild=x86"
)

declare -A clean_keys=(
    [3p]="$CURR_CDP/sdk/android/3p/build" 
    [cdphost]="$CURR_CDP/samples/CDPHost/android/app/build" 
    [rome_in]="$CURR_CDP/samples/romanapp/android/internal/build"
    [rome_ex]="$CURR_CDP/samples/romanapp/android/app/build"
    [dll_release]="$XAMARIN_PROJ/ConnectedDevices.Xamarin.Droid/bin"
    [app]="$XAMARIN_APP_DIR/ConnectedDevices.Xamarin.Droid.Sample/bin $XAMARIN_APP_DIR/ConnectedDevices.Xamarin.Droid.Sample/obj"
)

declare -A xam_keys=(
    [dll]="/t:Rebuild /p:Configuration=Debug $XAM_DLL_CSPROJ"
    [dll_release]="/t:Rebuild /p:Configuration=Release $XAM_DLL_CSPROJ"
    # Without SignAndroidPackage no APK is generated
    [app]="/t:Rebuild /t:SignAndroidPackage /p:Configuration=Debug $XAM_APP_CSPROJ"
    [app_release]="/t:Rebuild /t:SignAndroidPackage /p:Configuration=Release $XAM_APP_CSPROJ"
)

declare -A sign_input_keys=(
    [app]=$XAMARIN_APK_WIN/Debug/com.microsoft.romanapp.xamarin
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

declare -A install_keys=(
    [rome_in]=$ROME_IN_APK
    [xam]=$XAMARIN_APP_APK
    [xam_release]=$XAMARIN_APP_RELEASE_APK
    [cdphost]=$CDP_HOST_APK
    [tdd]=$TDD_RUNNER_APK
    # x86
    [rome_in_x86]=$ROME_IN_APK_X86
    [cdphost_x86]=$CDP_HOST_APK_X86
    [tdd_x86]=$TDD_RUNNER_APK_X86
)

declare -A jni_keys=(
    [platform_internal]="PlatformInternal"
)

declare -A adb_device_keys=(
    [vm]=-e
    [usb]=-d
)

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

_app_pull_log () { _adb_run pull $1/CDPTraces.log CDPTraces_android.log; }

_app_pull_dir () { _adb_run pull $1 ConnectedDevicesPlatform_android; }

_adb_shell () { _adb_run shell "$@"; }

_app_rm_log () { _adb_shell rm $1/CDPTraces.log; }

_app_launch () { _adb_shell monkey -p $1 -c android.intent.category.LAUNCHER 1; }

# android-app://com.microsoft.romanappinternal/http/microsoft.com 
# https://developer.android.com/reference/android/content/Intent.html#URI_ANDROID_APP_SCHEME

# adb -d shell am start -n com.microsoft.romanappinternal/com.microsoft.romanapp.LoginActivity


_app_close () { _adb_shell am force-stop $1; }

_app_nuke () { _adb_shell pm clear $1; }

_adb_swipe () { _adb_shell input swipe 200 900 200 100 100; }

_adb_power () { _adb_shell input keyevent 26; }

_adb_input_text () { _adb_shell input text "$1"; }

_adb_back () { _adb_shell input keyevent 3; }

_adb_ok () { _adb_shell input keyevent 66; }

_adb_tab () { _adb_shell input keyevent 61; }

#### Android Viewing + Interaction - Public Functions ####

ls_devices () { $ADB devices | grep "device$" | sed 's/ *device//g'; }

ls_device () { $ADB devices | grep "device$" | sed 's/ *device//g' | sed -n "$1"p; }

ls_apps () { $ADB ls $APP_DIR; }

ls_packages () { _choose_adb_device $1 && _adb_shell 'pm list packages -f' | sed -e 's/.*=//' | sort; }

adb_on () { _choose_adb_device $1 && _adb_power && _adb_swipe; }

adb_off () { _choose_adb_device $1 && _adb_power; }

# Delete the CDP log for the given app
rm_log () { _choose_adb_device $2 && _execute _app_rm_log app_keys $1; }

# Pull the CDP log for the given app
pull_log () { _choose_adb_device $2 && _execute _app_pull_log app_keys $1; }

# Pull the ConnectedDevicesPlatform directory for the given app
pull_dir () { _choose_adb_device $2 && _execute _app_pull_dir app_keys $1; }

# Open given application
launch () { _choose_adb_device $2 && _execute _app_launch app_name_keys $1; }

# Close given application
close () { _choose_adb_device $2 && _execute _app_close app_name_keys $1; }

# Close app process and clear out all the stored data for given that app
nuke () { _choose_adb_device $2 && _execute _app_nuke app_name_keys $1; }

# View logcat though a better view - https://github.com/JakeWharton/pidcat
logcat () { python "$D_WIN\git_repos\pidcat\pidcat.py" $@; }

adb_restart() { adb kill-server && adb start-server; }

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

#### Storing Files - Public Functions ####

# $1: Name of VM/PC which has a shared directory containing CDPTraces.log
store_log () { _copy_log $1 && _dmkdir_log && _mvlog "CDPTraces_PC" && cd "$DDIR" && exp; }

# Pull the log to the given application and given desktop directory log to a timestamp directory e.g. store_coa $CDP1_VM
# $1: Name of application to pull from
# $2: [Optional] Name of VM/PC which has a shared directory containing CDPTraces.log
store () { pull_log $1 && _dmkdir_log && _mvlog "CDPTraces_android" && cd "$DDIR" && exp && if [ $# -eq 2 ]; then $(_copy_log $2); fi; }

store_apk() { _choose_adb_device $2 && _execute _store_apk install_keys $1; }

#### Building Android - Private Functions ####

_gradlew () { dos2unix gradlew && $GRADLEW $1; }

_msbuild () { "$MSBUILD" $1; }

_clean () {  rm -rf $1; }

_install () { _adb_run install -r $1; }

_uninstall () { _adb_run uninstall $1; }

_build_jni () { cd "$CON_DEV_DIR" && "$JAVAH" -v -classpath "$JNI_CLASSPATH" com.microsoft.connecteddevices.$1 && cp "$CON_DEV_DIR\com_microsoft_connecteddevices_$1.h" "$CDP_JNI_DIR\com_microsoft_connecteddevices_$1.h"; }

_align_apk() { "$ZIP_ALIGN" 4 $1 $2; }

#### Building Android - Public Functions ####

# Using gradle, builds the given task
build() { _execute _gradlew build_keys $1; }

# Build the AAR, copies it and builds the DLL
# build_xam_dll() { build 3p && cp_aar && build_xam dll; }

# Removes all files under build dirs
clean() { _execute _clean clean_keys $1; }

# sign_debug <input_file> <output_file>
# sign_debug() { _align_apk "$1.apk" "$1.Aligned.apk" && "$APK_SIGNER" sign --ks "C:\Users\\$LOCAL_WIN_USER\.android\debug.keystore" --ks-pass pass:android --out "$1.MySigned.apk" "$1.Aligned.apk"; }

# sign_app() { _execute sign_debug sign_input_keys $1; }

sign_debug() { "$APK_SIGNER" sign --ks "C:\Users\\$LOCAL_WIN_USER\.android\debug.keystore" --ks-pass pass:android --out $2 $1; }

# Using MSBuild, build the given task
build_xam() { clean $1; _execute _msbuild xam_keys $1 && if [ ${sign_input_keys[$1]+exists} ]; then sign_app $1; fi; }

# Install the app's APK using ADB
adb_in() { _choose_adb_device $2 && close $1 && _execute _install install_keys $1 && launch $1; }

# Uninstall the app's APK using ADB
adb_un() { _choose_adb_device $2 && close $1 && _execute _uninstall app_name_keys $1; }

# Package all 3P SDK files in a local directory
package_3p () { $SCRIPTS/Deploy-Android-3p-SDK.cmd -iteration 1703; }

# Package all 3P SDK files in a network directory
deploy_3p () { $SCRIPTS/Deploy-Android-3p-SDK.cmd -iteration 1703 -network; }

# Package all 3P SDK files in a local directory
package_1p () { $SCRIPTS/Deploy-Android-1p-SDK.cmd -iteration 1703; }

# Package all 3P SDK files in a network directory
deploy_1p () { $SCRIPTS/Deploy-Android-1p-SDK.cmd -iteration 1703 -network; }

cp_aar () { cp $AAR_SRC_ARR $AAR_DEST_ARR && echo "Copied AAR file to Xamarin destination"; }

prep_xam () { build 3p_release && cp_aar && build_xam dll; }

build_jni() { _execute _build_jni jni_keys $1; }

#### TDD commands ####

# Run TDD on Android with the input. If $2 is set, use it, otherwise pass 1
tdd_run () { _choose_adb_device $2 && _adb_shell am start -S -n $TDDRUNNER_NAME/.TddRunner --es name $1 --ez trx true --ez log true; }

tdd_run_repeat () { _choose_adb_device $3 && _adb_shell am start -S -n $TDDRUNNER_NAME/.TddRunner --es name $1 --ei repeat $2; }

# Run TDD on Android with the input in debug mode. If $2 is set, use it, otherwise pass 1
tdd_run_deb () { _choose_adb_device $2 && _adb_shell am start -S -D -n $TDDRUNNER_NAME/.TddRunner --es name $1; }

tdd_run_deb_repeat () { _choose_adb_device $3 && _adb_shell am start -S -D -n $TDDRUNNER_NAME/.TddRunner --es name $1 --ei repeat $2; }
# https://developer.android.com/studio/command-line/adb.html#IntentSpec

tdd_files () { _choose_adb_device $1 && _adb_shell ls /data/user/0/$TDDRUNNER_NAME/files/trx; }

tdd_pull () { _choose_adb_device $1 && _adb_root; _adb_run pull /data/user/0/$TDDRUNNER_NAME/files/trx && _adb_run pull /data/user/0/$TDDRUNNER_NAME/files/logcat_dump; }

tdd_in_run() { adb_in tdd $2 && tdd_run $1 $2; }


# Get OS version
# echo $(adb shell getprop ro.build.version.release | tr -d '\r')


# adb -d shell am start -n com.microsoft.romanappinternal/com.microsoft.romanapp.LoginActivity
# adb -e shell am start -S -D -n com.microsoft.romanappinternal/com.microsoft.romanapp.LoginActivity
