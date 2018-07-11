######### CONSTANTS ########

#### Machine Specific Paths ####

# Disks
SHELL_DRIVE="/cygdrive"
C="$SHELL_DRIVE/c"; export C
E="$SHELL_DRIVE/e"; export E
L="$SHELL_DRIVE/l"; export L
F="$SHELL_DRIVE/f"; export F
X="$SHELL_DRIVE/x"; export X
Z="//anpea-dev/c$"; export Z

# CDP directories
STORAGE="$E"
GIT_REPOS="$STORAGE/git_repos"
CDP_1="$GIT_REPOS/cdp1"
CDP_2="$GIT_REPOS/cdp2"
CDP_3="$GIT_REPOS/cdp3"

# Windows user name
LOCAL_WIN_USER="anpea"
# Bash shell name
LOCAL_BASH_USER="anpea"
# MS alias for network directory
GLOBAL_USER="anpea"

# Paths in Windows format due to certain input requirements
C_WIN="C:"
E_WIN="E:"

GIT_REPOS_WIN="$E_WIN/git_repos"
CDP_1_WIN="$GIT_REPOS_WIN/cdp1"
CDP_2_WIN="$GIT_REPOS_WIN/cdp2"
CDP_3_WIN="$GIT_REPOS_WIN/cdp3"
WORK_WIN="$E_WIN/work_files"
BASH_REPO="$GIT_REPOS_WIN\bash"
MY_HOME_WIN="$C_WIN\cygwin64\home\\$LOCAL_WIN_USER"
USER_DIR="$C/Users/$LOCAL_WIN_USER"

# Application directories
# Do not set this to "$C/tools/adt-bundle-windows-x86_64-20140702/sdk"
ANDROID_SDK="$E/android-sdk"
ADB="$ANDROID_SDK/platform-tools/adb"
MONITOR="$ANDROID_SDK/tools/lib/monitor-x86_64/monitor.exe"
XDE="$C/Program Files (x86)/Microsoft XDE/10.0.10586.0/XDE.exe"
MSBUILD="$C/Program Files (x86)/MSBuild/14.0/Bin/MSBuild.exe"
APK_SIGNER="$ANDROID_SDK_BUILD_TOOLS/apksigner.bat"
ZIP_ALIGN="$ANDROID_SDK_BUILD_TOOLS/zipalign.exe"
DEXDUMP="$ANDROID_SDK_BUILD_TOOLS/dexdump.exe"
VS_HOME="$C/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio\ 14.0/Common7"
CMAKE_HOME="$USER_DIR/AppData/Local/Android/sdk/cmake/3.6.4111459"
TAEF="$C/testexecution/TE.exe"
# Due to the spaces in the path and the difference between aliases and functions, two seperate variables are required
SUBL_ALIAS="$C/Program\ Files/Sublime\ Text\ 3/subl.exe"
SUBL_FUNC="$C/Program Files/Sublime Text 3/subl.exe"

# Git Repo locations of importanace
COA="$GIT_REPOS/CortanaAndroid"
PROJECT_ROME_GITHUB="$GIT_REPOS/project-rome"
CDP_PINGPONG="$GIT_REPOS/CDPPingPong"
MS_OS="$GIT_REPOS/os/src"
OS_APP_CONTRACTS="$MS_OS/onecoreuap/base/appmodel/AppContracts"
OS_CDP="$MS_OS/onecoreuap/windows/cdp"
CDP2OS="$GIT_REPOS/cdp2os"
MMX="$GIT_REPOS/Shell.MMX/android/components/AgentsAPI"
BASH="$GIT_REPOS/bash"

######### DEPENDENT ON WHAT DIR YOU'RE IN ########

ANDROID_SDK_BUILD_TOOLS="$USER_DIR/AppData/Local/Android/sdk/build-tools/25.0.0"
WSL_HOME="$USER_DIR/AppData/Local/lxss/home/$LOCAL_WIN_USER"
DOWNLOADS="$USER_DIR/Downloads"

VS_TOOLS="$E/Microsoft\ Visual\ Studio/2017/Enterprise/VC/Tools"
DUMPBIN="$VS_TOOLS/MSVC/14.14.26428/bin/Hostx64/x64/dumpbin.exe"

# Local log directories
SYS_CDP_WIN="\"$C_WIN\\Windows\\ServiceProfiles\\LocalService\\AppData\\Local\\ConnectedDevicesPlatform\""
USER_CDP_WIN="\"$C_WIN\\Users\\$LOCAL_WIN_USER\\AppData\\Local\\ConnectedDevicesPlatform\""

SYS_CDP="$C/Windows/ServiceProfiles/LocalService/AppData/Local/ConnectedDevicesPlatform"
USER_CDP="$USER_DIR/AppData/Local/ConnectedDevicesPlatform"

# VM Paths
CDP1="\\\\DESKTOP-5MMAKOD"
CDP2="\\\\DESKTOP-4HQ4UEA"
MASTER="\\\\DESKTOP-CTKCQFE"
RS1="\\\\DESKTOP-KDTTPVC"
OFFICIAL="\\\\DESKTOP-NM3ECF2"
LAPTOP="\\\\DESKTOP-02BI2KL"
DEVBOX="$C_WIN\\Windows\\ServiceProfiles\\LocalService\\AppData\\Local"

# Network directories
VM_DIR="//winbuilds/release/RS_ONECORE_DEP_ACI/"
RELEASE_VM_DIR="//winbuilds/release/RS2_RELEASE/"
MY_NETWORK_DIR="//redmond/osg/release/DEP/CDP/$GLOBAL_USER"
ROME_DROP="//redmond/osg/release/dep/CDP/V3Partners"
CURRENT_ROME_DROP="$ROME_DROP/Rome_1705"

######### DEPENDENT ON WHAT USER YOU ARE ########

# Note files directories
# Machine specific paths
NOTES="$C/notes"
WORK="$STORAGE/work_files"
MY_HOME="$C/cygwin64/home/$LOCAL_BASH_USER"


# CDP paths scripts
MY_ENLISTMENT="$F/enlistments"

# Application directories
JAVA="$JAVA_HOME/bin/java.exe"
JAVAC="$JAVA_HOME/bin/javac.exe"
JAVAP="$JAVA_HOME/bin/javap.exe"
JAVAH="$JAVA_HOME/bin/javah.exe"
KEYTOOL="$JAVA_HOME/jre/bin/keytool.exe"
VS="$VS_HOME/IDE/devenv.exe"
NUGET="$C/tools/NuGet/nuget.exe"
CMAKE="$CMAKE_HOME/bin/cmake.exe"
JUNIT="$C/Program Files/Android/Android Studio/lib/junit.jar"

#### Machine Independent Variables ####

# Set the default CDP repo as 1
CURR_CDP="$CDP_1"
CURR_CDP_WIN="$CDP_1_WIN"

# Required for pidcat
export PATH=$PATH:$ANDROID_SDK/platform-tools
export PATH=$PATH:$ANDROID_SDK/tools

# Function for assigning variables
set_var() { printf -v $1 "$2"; }

set_android_app_variables()
{
    set_var $1_APP_FILES "$DEVICE_DATA/$2/files";
    set_var $1_APK_DIR "$SAMPLES/$3/$BUILD_APK_DIR/$TYPE_DEBUG";
    set_var $1_APK_DIR_WIN "$SAMPLES_WIN/$3/$BUILD_APK_DIR";
    set_var $1_APK "$SAMPLES_WIN/$3/$BUILD_APK_DIR/$TYPE_DEBUG/$4-$ARCH_ARM-$TYPE_DEBUG.apk";
}

set_variables()
{
    set_var SCRIPTS_WIN $CURR_CDP_WIN'/tools/scripts';
    set_var ANDROID_SCRIPTS_WIN $SCRIPTS_WIN'/Test/android';
    set_var CDP_UT_X64_DEBUG $CURR_CDP_WIN'\\_build\\onecore\\x64\\debug\\bin\\tests\\cdp_ut.dll';
    set_var CDP_UT_X64_RELEASE $CURR_CDP_WIN'\\_build\\onecore\\x64\\release\\bin\\tests\\cdp_ut.dll';

    set_var SAMPLES "$CURR_CDP/samples"
    set_var SAMPLES_WIN "$CURR_CDP_WIN/samples"

    set_var BUILD_APK_DIR "android/app/build/outputs/apk";
    set_var DEVICE_DATA "sdcard/Android/data";

    set_var ARCH_ARM "armeabi-v7a"
    set_var ARCH_X86 "x86"
    set_var TYPE_DEBUG "debug"
    set_var TYPE_RELEASE "release"

    # Third Party SDK - DEPRECIATED
    set_var CDP_ANDROID_SDK_DIR "$CURR_CDP\sdk\android";
    set_var SDK_3P_AAR "$CDP_ANDROID_SDK_DIR/3p/build/outputs/aar";

    # Xamarin SDK
    set_var XAMARIN_PROJ_DIR "$CURR_CDP/sdk/xamarin";
    set_var XAMARIN_PROJ_WIN_DIR "$CURR_CDP_WIN/sdk/xamarin";
    set_var XAMARIN_DLL "$XAMARIN_PROJ_DIR/ConnectedDevices.Xamarin.Droid/bin";

    # OneRomanApp
    set_var ONE_ROMAN_APP_NAME "com.microsoft.oneRomanApp";
    set_var ONE_ROMAN_APP_DIR_NAME "oneromanapp";
    set_var ONE_ROMAN_APP_TITLE "oneRomanApp";

    set_android_app_variables ONE_ROME $ONE_ROMAN_APP_NAME $ONE_ROMAN_APP_DIR_NAME $ONE_ROMAN_APP_TITLE

    # Xamarin RomanApp
    set_var XAMARIN_APP_DIR_NAME "xamarinsample";
    set_var XAMARIN_APP_NAME "com.microsoft.romanapp.xamarin";
    set_var XAMARIN_APP_TITLE "com.microsoft.romanapp.xamarin";

    set_var XAMARIN_APP_DIR "$SAMPLES/$XAMARIN_APP_DIR_NAME";
    set_var XAMARIN_APP_WIN_DIR "$SAMPLES_WIN/$XAMARIN_APP_DIR_NAME";
    set_var XAMARIN_APK "$XAMARIN_APP_DIR/ConnectedDevices.Xamarin.Droid.Sample/bin";
    set_var XAMARIN_APP_APK_DIR_WIN "$XAMARIN_APP_WIN_DIR/ConnectedDevices.Xamarin.Droid.Sample/obj/Debug/android/bin";
    set_var XAMARIN_APP_RELEASE_APK_DIR_WIN "$XAMARIN_APP_WIN_DIR/ConnectedDevices.Xamarin.Droid.Sample/bin/Release";
    set_var XAMARIN_APK_WIN "$SAMPLES_WIN/$XAMARIN_APP_DIR_NAME/ConnectedDevices.Xamarin.Droid.Sample/bin";
    set_var XAMARIN_APP_FILES "$DEVICE_DATA/$XAMARIN_APP_NAME/files";
    
    set_var XAMARIN_APP_APK "$XAMARIN_APP_APK_DIR_WIN/$XAMARIN_APP_TITLE.MySigned.apk";
    set_var XAMARIN_APP_RELEASE_APK "$XAMARIN_APP_RELEASE_APK_DIR_WIN/$XAMARIN_APP_TITLE-Signed.apk";
    
    # CDPHost
    set_var CDP_HOST_NAME "com.microsoft.cdp.cdphost";
    set_var CDP_HOST_DIR_NAME "CDPHost";
    set_var CDP_HOST_TITLE "cdphost";
    
    set_android_app_variables CDP_HOST $CDP_HOST_NAME $CDP_HOST_DIR_NAME $CDP_HOST_TITLE
    
    set_var CDP_HOST_FILES "$DEVICE_DATA/$CDP_HOST_NAME/files";
    set_var CDP_HOST_APK_DIR_WIN "$SAMPLES_WIN/$CDP_HOST_DIR_NAME/$BUILD_APK_DIR";
    set_var CDP_HOST_APK "$CDP_HOST_APK_DIR_WIN/$CDP_HOST_TITLE-armv7-$TYPE_DEBUG.apk";
    set_var CDP_HOST_APK_X86 "$CDP_HOST_APK_DIR_WIN/$CDP_HOST_TITLE-$ARCH_X86-$TYPE_DEBUG.apk";
    
    # TDD Runner
    set_var TDDRUNNER_DIR_NAME "tdd/runners";
    set_var TDDRUNNER_NAME "com.microsoft.tddrunner";
    set_var TDDRUNNER_TITLE "tdd";

    set_var TDD_RUNNER_APK_DIR_WIN "$CURR_CDP_WIN/test/$TDDRUNNER_DIR_NAME/$BUILD_APK_DIR";
    set_var TDDRUNNER_FILES "$DEVICE_DATA/$TDDRUNNER_NAME/files";
    set_var TDD_RUNNER_APK "$TDD_RUNNER_APK_DIR_WIN/$TDDRUNNER_TITLE-$ARCH_ARM-$TYPE_DEBUG.apk";
    set_var TDD_RUNNER_APK_X86 "$TDD_RUNNER_APK_DIR_WIN/$TDDRUNNER_TITLE-$ARCH_X86-$TYPE_DEBUG.apk";

    #### Miscellaneous Related Variables ####
    set_var TDD "$CURR_CDP/build/onecorefast/x64/debug/tests";

    #### Android Related Variables ####
    set_var LOG_DUMP_DIR "$WORK/stored_logs";
    set_var APK_DIR "$WORK/stored_apks";
    set_var GRADLEW "$CURR_CDP/gradlew";

    set_var MAVEN_MINOR_VERSION $(cat "$CURR_CDP/gradle.properties" | grep mavenMinorVersion | sed -e 's/.*= //');
}

set_variables