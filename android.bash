#### Key Declarations ####

set_android_arrays()
{
    declare -g -A app_keys=(
        # OneRomanApp
        [one_rome]=$ONE_ROME_APP_FILES
        [one_rome_release]=$ONE_ROME_APP_FILES
        [one_rome_x86]=$ONE_ROME_APP_FILES
        [one_rome_x86_release]=$ONE_ROME_APP_FILES
        # Xamarin RomanApp
        [xam]=$XAMARIN_APP_FILES
        [xam_release]=$XAMARIN_APP_FILES
        [xam_x86]=$XAMARIN_APP_FILES
        [xam_x86_release]=$XAMARIN_APP_FILES
        # CDPHost
        [cdphost]=$CDP_HOST_FILES
        [cdphost_release]=$CDP_HOST_FILES
        [cdphost_x86]=$CDP_HOST_FILES
        [cdphost_x86_release]=$CDP_HOST_FILES
        # TDD Runner
        [tdd]=$TDDRUNNER_FILES
        [tdd_release]=$TDDRUNNER_FILES
        [tdd_x86]=$TDDRUNNER_FILES
        [tdd_x86_release]=$TDDRUNNER_FILES
    )

    declare -g -A app_name_keys=(
        # OneRomanApp
        [one_rome]=$ONE_ROMAN_APP_NAME
        [one_rome_release]=$ONE_ROMAN_APP_NAME
        [one_rome_x86]=$ONE_ROMAN_APP_NAME
        [one_rome_x86_release]=$ONE_ROMAN_APP_NAME
        # Xamarin RomanApp
        [xam]=$XAMARIN_APP_NAME
        [xam_release]=$XAMARIN_APP_NAME
        [xam_x86]=$XAMARIN_APP_NAME
        [xam_x86_release]=$XAMARIN_APP_NAME
        # CDPHost
        [cdphost]=$CDP_HOST_NAME
        [cdphost_release]=$CDP_HOST_NAME
        [cdphost_x86]=$CDP_HOST_NAME
        [cdphost_x86_release]=$CDP_HOST_NAME
        # TDD Runner
        [tdd]=$TDDRUNNER_NAME
        [tdd_release]=$TDDRUNNER_NAME
        [tdd_x86]=$TDDRUNNER_NAME
        [tdd_x86_release]=$TDDRUNNER_NAME
    )

    declare -g -A app_name_deb_keys=(
        # OneRomanApp
        [one_rome]=$ONE_ROMAN_APP_NAME/.MainActivity
        [one_rome_release]=$ONE_ROMAN_APP_NAME/.MainActivity
        [one_rome_x86]=$ONE_ROMAN_APP_NAME/.MainActivity
        [one_rome_x86_release]=$ONE_ROMAN_APP_NAME/.MainActivity
        # Xamarin RomanApp
        [xam]=$XAMARIN_APP_NAME
        [xam_release]=$XAMARIN_APP_NAME
        [xam_x86]=$XAMARIN_APP_NAME
        [xam_x86_release]=$XAMARIN_APP_NAME
        # CDPHost
        [cdphost]=$CDP_HOST_NAME
        [cdphost_release]=$CDP_HOST_NAME
        [cdphost_x86]=$CDP_HOST_NAME
        [cdphost_x86_release]=$CDP_HOST_NAME
        # TDD Runner
        [tdd]=$TDDRUNNER_NAME/.TddRunner
        [tdd_release]=$TDDRUNNER_NAME/.TddRunner
        [tdd_x86]=$TDDRUNNER_NAME/.TddRunner
        [tdd_x86_release]=$TDDRUNNER_NAME/.TddRunner
    )

tdd_run_deb () { _choose_adb_device $2 && _adb_shell am start -S -D -n $TDDRUNNER_NAME/.TddRunner --es name $1; }


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

    declare -g -A build_keys=(
        # First Party SDK - DEPRECIATED
        [1p]="sdk_1p:assembleDebug"
        [1p_release]="sdk_1p:assembleRelease"
        # Third Party SDK - DEPRECIATED
        [3p]="sdk_3p:assembleDebug"
        [3p_release]="sdk_3p:assembleRelease"
        # Converged SDK
        [conv]="sdk_converged:assembleDebug"
        [conv_release]="sdk_converged:assembleRelease"
        [conv_x86]="sdk_converged:assembleDebug -PabiToBuild=x86"
        [conv_release_x86]="sdk_converged:assembleRelease -PabiToBuild=x86"
        # OneRomanApp
        [one_rome]=":oneRomanApp:assembleDebug"
        [one_rome_release]=":oneRomanApp:assembleRelease"
        [one_rome_x86]=":oneRomanApp:assembleDebug -PabiToBuild=x86"
        [one_rome_x86_release]=":oneRomanApp:assembleRelease -PabiToBuild=x86"
        # WNS Ping Test Application
        [wnsping]=":wnspingtest:assembleDebug"
        [wnsping_release]=":wnspingtest:assembleRelease"
        [wnsping_x86]=":wnspingtest:assembleDebug -PabiToBuild=x86"
        [wnsping_release_x86]=":wnspingtest:assembleRelease -PabiToBuild=x86"
        # CDP Host
        [cdphost]="cdphost:assembleDebug"
        [cdphost_release]="cdphost:assembleRelease"
        [cdphost_x86]="cdphost:assembleDebug -PabiToBuild=x86"
        [cdphost_release_x86]="cdphost:assembleRelease -PabiToBuild=x86"
        # TDD Runner
        [tdd]="tdd:assembleDebug"
        [tdd_release]="tdd:assembleRelease"
        [tdd_x86]="tdd:assembleDebug -PabiToBuild=x86"
        [tdd_release_x86]="tdd:assembleRelease -PabiToBuild=x86"
        # Converged SDK Tests
        [sdk_test]="sdk_converged:assembleDebug sdk_test:connectedDebugAndroidTest"
        [sdk_test_release]="sdk_converged:assembleDebug sdk_test:connectedReleaseAndroidTest -PinstrumentedTestBuildType=release"
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

    declare -g -A jni_keys=(
        [platform_internal]="PlatformInternal"
    )

    declare -g -A adb_device_keys=(
        [vm]=-e
        [usb]=-d
    )
}

set_android_arrays

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

_app_launch_deb () { _adb_shell am start -S -D -n $1; }

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

launch_deb () { _choose_adb_device $2 && _execute _app_launch_deb app_name_deb_keys $1; }

# Close given application
close () { _choose_adb_device $2 && _execute _app_close app_name_keys $1; }

restart () { close $1 $2 && launch $1 $2; }

# Close app process and clear out all the stored data for given that app
nuke () { _choose_adb_device $2 && _execute _app_nuke app_name_keys $1; }

# View logcat though a better view - https://github.com/JakeWharton/pidcat
logcat () { python "$D_WIN\git_repos\pidcat\pidcat.py" $@; }

adb_restart() { adb kill-server && sleep 1 && adb start-server; }

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

_javap () { javap -classpath $CLASSES_JAR "com.microsoft.connecteddevices.$1"; }

_build_jni () { cd "$CON_DEV_DIR" && "$JAVAH" -v -classpath "$JNI_CLASSPATH" com.microsoft.connecteddevices.$1 && cp "$CON_DEV_DIR\com_microsoft_connecteddevices_$1.h" "$CDP_JNI_DIR\com_microsoft_connecteddevices_$1.h"; }

_build_jni_test () { cd "$CON_TEST_DIR" && "$JAVAH" -v -classpath "$JNI_CLASSPATH" com.microsoft.connecteddevices.$1 && cp "$CON_TEST_DIR\com_microsoft_connecteddevices_$1.h" "$CDP_JNI_DIR\com_microsoft_connecteddevices_$1.h"; }

_align_apk() { "$ZIP_ALIGN" 4 $1 $2; }

#### Building Android - Public Functions ####

# Using gradle, builds the given task
build() { _execute _gradlew build_keys $1; }

build_n() { _execute_notify _gradlew build_keys $1; }

build_in() { build $1 && adb_in $1 $2; }

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

# https://superuser.com/questions/345447/how-can-i-trigger-a-notification-when-a-job-process-ends