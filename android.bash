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
)

declare -A build_keys=(
  [1p]="sdk_1p:assembleDebug"
  [1p_release]="sdk_1p:assembleRelease"
  [3p]="sdk_3p:assembleDebug"
  [3p_release]="sdk_3p:assembleRelease"
  [rome_in]="romanAppInternal:assembleDebug"
  [rome_in_release]="romanAppInternal:assembleRelease"
  [rome_ex]=":romanApp:assembleDebug"
  [rome_ex_release]=":romanApp:assembleRelease"
  [wnsping]=":wnspingtest:assembleDebug"
  [wnsping_release]=":wnspingtest:assembleRelease"
  [cdphost]="cdphost:assembleDebug"
  [cdphost_release]="cdphost:assembleRelease"
)

declare -A clean_keys=(
  [3p]="$CDP_1/sdk/android/3p/build" 
  [cdphost]="$CDP_1/samples/CDPHost/android/app/build" 
  [rome_in]="$CDP_1/samples/romanapp/android/internal/build"
  [rome_ex]="$CDP_1/samples/romanapp/android/app/build"
  [dll_release]="$XAMARIN_PROJ/ConnectedDevices.Xamarin.Droid/bin"
  [app]="$XAMARIN_APP/ConnectedDevices.Xamarin.Droid.Sample/bin $XAMARIN_APP/ConnectedDevices.Xamarin.Droid.Sample/obj"
)

declare -A xam_keys=(
  [dll]="/t:Rebuild /p:Configuration=Debug $XAM_DLL_CSPROJ"
  [dll_release]="/t:Rebuild /p:Configuration=Release $XAM_DLL_CSPROJ"
  # Without SignAndroidPackage no APK is generated
  [app]="/t:Rebuild /t:SignAndroidPackage /p:Configuration=Debug $XAM_APP_CSPROJ"
  [app_release]="/t:Rebuild /t:SignAndroidPackage /p:Configuration=Release $XAM_APP_CSPROJ"
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
  # [rome_ex]=$CDP2
)

declare -A jni_keys=(
  [platform_internal]="PlatformInternal"
)

#### Android Viewing + Interaction - Private Functions ####

_app_rm_log () { $ADB shell rm $1/CDPTraces.log; }

_app_pull_log () { $ADB pull $1/CDPTraces.log CDPTraces_android.log; }

_app_pull_dir () { $ADB pull $1 ConnectedDevicesPlatform_android; }

_app_launch () { $ADB shell monkey -p $1 -c android.intent.category.LAUNCHER 1; }

_app_stop () { $ADB shell am force-stop $1; }

_app_nuke () { $ADB shell pm clear $1; }

#### Android Viewing + Interaction - Public Functions ####

ls_devices () { $ADB devices | grep "device$" | sed 's/ *device//g'; }

ls_device () { $ADB devices | grep "device$" | sed 's/ *device//g' | sed -n "$1"p; }

ls_apps () { $ADB ls $APP_DIR; }

# Delete the CDP log for the given app
rm_log () { _execute _app_rm_log app_keys $1; }

# Pull the CDP log for the given app
pull_log () { _execute _app_pull_log app_keys $1; }

# Pull the ConnectedDevicesPlatform directory for the given app
pull_dir () { _execute _app_pull_dir app_keys $1; }

# Open given application
launch () { _execute _app_launch app_name_keys $1; }

# Stop given application
stop () { _execute _app_stop app_name_keys $1; }

# Close app process and clear out all the stored data for given that app
nuke () { _execute _app_nuke app_name_keys $1; }

# View logcat though a better view - https://github.com/JakeWharton/pidcat
logcat () { python "$D_WIN\git_repos\pidcat\pidcat.py" $1; }

#### Storing Logs - Private Functions ####

# Generate Date Time Stamp
_dts() { date +%Y-%m-%d-%H-%M-%S; }

# Create a directory with timestamp
_dmkdir() { DDIR="$LOG_DUMP_DIR/$(_dts)"; mkdir $DDIR && return 0; }

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

_msbuild () { "$MSBUILD" $1; }

_clean () {  rm -rf $1; }

_install () { $ADB install -r $1; }

_build_jni () { cd "$CON_DEV_DIR" && "$JAVAH" -v -classpath "$JNI_CLASSPATH" com.microsoft.connecteddevices.$1 && cp "$CON_DEV_DIR\com_microsoft_connecteddevices_$1.h" "$CDP_JNI_DIR\com_microsoft_connecteddevices_$1.h"; }

#### Building Android - Public Functions ####

# Using gradle, builds the given task
build() { _execute _gradlew build_keys $1; }

# Build the AAR, copies it and builds the DLL
# build_xam_dll() { build 3p && cp_aar && build_xam dll; }

# Removes all files under build dirs
clean() { _execute _clean clean_keys $1; }

# sign_debug <input_file> <output_file>
sign_debug() { "$APK_SIGNER" sign --ks "C:\Users\\$LOCAL_WIN_USER\.android\debug.keystore" --ks-pass pass:android --out $2 $1; }

# Using MSBuild, build the given task
build_xam() { clean $1; _execute _msbuild xam_keys $1; }

# Install the app's APK using ADB
adb_in() { stop $1 && _execute _install install_keys $1 && launch $1; }

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
tdd_run () { repeat=${2-1}; $ADB shell am start -S -n $TDDRUNNER_NAME/.TddRunner --es name $1 --ei repeat $repeat; }

# Run TDD on Android with the input in debug mode. If $2 is set, use it, otherwise pass 1
tdd_run_deb () { repeat=${2-1}; $ADB shell am start -S -D -n $TDDRUNNER_NAME/.TddRunner --es name $1 --ei repeat $repeat; }