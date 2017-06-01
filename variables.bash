#### Machine Specific Paths ####

# Disks
SHELL_DRIVE="/cygdrive"
C="$SHELL_DRIVE/c"; export C
D="$SHELL_DRIVE/d"; export D
L="$SHELL_DRIVE/l"; export L
F="$SHELL_DRIVE/f"; export F
X="$SHELL_DRIVE/x"; export X
Z="//anpea-dev/c$"; export Z

# CDP directories
GIT_REPOS="$D/git_repos"
CDP_1="$GIT_REPOS/cdp"
CDP_2="$GIT_REPOS/cdp_2"
CDP_MASTER="$GIT_REPOS/cdp_master"

# Windows user name
LOCAL_WIN_USER="anpea"
# Bash shell name
LOCAL_BASH_USER="anpea"
# MS alias for network directory
GLOBAL_USER="anpea"

# Note files directories
# Machine specific paths
WORK="$D/work_files"
MY_HOME="$C/cygwin64/home/$LOCAL_BASH_USER"
ANDROID_SDK="$C/tools/adt-bundle-windows-x86_64-20140702/sdk"
ANDROID_SDK_BUILD_TOOLS="$C/Users/$LOCAL_WIN_USER/AppData/Local/Android/sdk/build-tools/25.0.0"
WSL_HOME="$C/Users/anpea/AppData/Local/lxss/home/anpea"

# Application directories
ADB="$ANDROID_SDK/platform-tools/adb"
MSBUILD="$C/Program Files (x86)/MSBuild/14.0/Bin/MSBuild.exe"
APK_SIGNER="$ANDROID_SDK_BUILD_TOOLS/apksigner.bat"
ZIP_ALIGN="$ANDROID_SDK_BUILD_TOOLS/zipalign.exe"
VS_HOME="$C/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio\ 14.0/Common7"
CMAKE_HOME="$C/Users/$LOCAL_WIN_USER/AppData/Local/Android/sdk/cmake/3.6.3155560"
# Due to the spaces in the path and the difference between aliases and functions, two seperate variables are required
SUBL_ALIAS="$C/Program\ Files/Sublime\ Text\ 3/subl.exe"
SUBL_FUNC="$C/Program Files/Sublime Text 3/subl.exe"

# CDP paths scripts
SCRIPTS="$CDP_1/tools/scripts"
MY_ENLISTMENT="$F/enlistments"
MY_JAVA_HOME="$C/Program Files/Java/jdk1.8.0_121"

# Paths in Windows format due to certain input requirements
C_WIN="C:"
D_WIN="D:"

CDP_1_WIN="$D_WIN/git_repos/cdp"
WORK_WIN="$D_WIN/work_files"
MY_HOME_WIN="$C_WIN/cygwin64/home/$LOCAL_WIN_USER"

#### Machine Independent Variables ####

# Enlistment directories
ENLISTMENT_CDP="$MY_ENLISTMENT/onecoreuap/windows/cdp"
ENLISTMENT_APP_CONTRACT="$MY_ENLISTMENT/onecoreuap/base/appmodel/AppContracts"

# Git Repo locations of importanace
COA="$GIT_REPOS/CortanaAndroid"
PROJECT_ROME_GITHUB="$GIT_REPOS/project-rome"
CDP_PINGPONG="$GIT_REPOS/CDPPingPong"
TDD="$CDP_1/build/onecorefast/x64/debug/tests"
ROME_APP="$CDP_1/samples/romanapp/android"
XAMARIN_APP_DIR="$CDP_1/samples/xamarinsample"
XAMARIN_PROJ="$CDP_1/sdk/xamarin"
CDP_ANDROID_SDK="$CDP_1\sdk\android"

ROME_APP_WIN="$CDP_1_WIN\samples\romanapp\android"
XAMARIN_APP_WIN="$CDP_1_WIN\samples\xamarinsample"
XAMARIN_PROJ_WIN="$CDP_1_WIN\sdk\xamarin"

# APK locations
XAMARIN_APK="$XAMARIN_APP_DIR/ConnectedDevices.Xamarin.Droid.Sample/bin"
ROME_IN_APK_DIR="$ROME_APP/app/build/outputs/apk"
SDK_3P_AAR="$CDP_ANDROID_SDK\3p\build\outputs\aar"
XAMARIN_DLL="$XAMARIN_PROJ/ConnectedDevices.Xamarin.Droid/bin"

XAMARIN_APK_WIN="$CDP_1_WIN/samples/xamarinsample/ConnectedDevices.Xamarin.Droid.Sample/bin"

# Network directories
VM_DIR="//winbuilds/release/RS_ONECORE_DEP_ACI/"
RELEASE_VM_DIR="//winbuilds/release/RS2_RELEASE/"
MY_NETWORK_DIR="//redmond/osg/release/DEP/CDP/$GLOBAL_USER"
ROME_DROP="//redmond/osg/release/dep/CDP/V3Partners"
CURRENT_ROME_DROP="$ROME_DROP/Rome_1705"

# Application directories
JAVAC="$MY_JAVA_HOME/bin/javac.exe"
JAVAP="$MY_JAVA_HOME/bin/javap.exe"
JAVAH="$MY_JAVA_HOME/bin/javah.exe"
KEYTOOL="$MY_JAVA_HOME/jre/bin/keytool.exe"
VS="$VS_HOME/IDE/devenv.exe"
NUGET="$C/tools/NuGet/nuget.exe"
CMAKE="$CMAKE_HOME/bin/cmake.exe"

# Local log directories
SYS_CDP_WIN="\"$C_WIN\\Windows\\ServiceProfiles\\LocalService\\AppData\\Local\\ConnectedDevicesPlatform\""
USER_CDP_WIN="\"$C_WIN\\Users\\$LOCAL_WIN_USER\\AppData\\Local\\ConnectedDevicesPlatform\""

SYS_CDP="$C/Windows/ServiceProfiles/LocalService/AppData/Local/ConnectedDevicesPlatform"
USER_CDP="$C/Users/$LOCAL_WIN_USER/AppData/Local/ConnectedDevicesPlatform"

#### Android Related Variables ####

# Required for pidcat
export PATH=$PATH:$ANDROID_SDK/platform-tools
export PATH=$PATH:$ANDROID_SDK/tools

LOG_DUMP_DIR="$WORK/stored_logs"
GRADLEW="$CDP_1/gradlew"

# TODO: Use mavenMinorVersion to find 3P SDK AAR version
AAR_SRC_ARR="$SDK_3P_AAR\connecteddevices-sdk-armv7-0.3.0-release.aar"
AAR_DEST_ARR="$XAMARIN_PROJ\ConnectedDevices.Xamarin.Droid\Jars\connecteddevices-sdk-armv7-externalRelease.aar"

# VM Paths
CDP1="\\\\DESKTOP-5MMAKOD"
CDP2="\\\\DESKTOP-4HQ4UEA"
MASTER="\\\\DESKTOP-CTKCQFE"
RS1="\\\\DESKTOP-KDTTPVC"
OFFICIAL="\\\\DESKTOP-NM3ECF2"
LAPTOP="\\\\DESKTOP-02BI2KL"
DEVBOX="$C_WIN\\Windows\\ServiceProfiles\\LocalService\\AppData\\Local"

# Android Constants
CDP_HOST_NAME="com.microsoft.cdp.CDPHost"
CORTANA_NAME="com.microsoft.cortana"
TDDRUNNER_NAME="com.microsoft.tddrunner"
ROMAN_APP_NAME="com.microsoft.romanapp"
ROMAN_APP_IN_NAME="com.microsoft.romanappinternal"
XAMARIN_APP_NAME="com.microsoft.romanapp.xamarin"

APP_DIR="sdcard/Android/data"
CDP_HOST="$APP_DIR/$CDP_HOST_NAME/files"
CORTANA="$APP_DIR/$CORTANA_NAME/files"
TDDRUNNER="$APP_DIR/$TDDRUNNER_NAME/files"
ROMAN_APP="$APP_DIR/$ROMAN_APP_NAME/files"
ROMAN_APP_IN="$APP_DIR/$ROMAN_APP_IN_NAME/files"
XAMARIN_APP="$APP_DIR/$XAMARIN_APP_NAME/files"

# CDP Build paths
ROME_IN_APK="$ROME_APP_WIN\app\build\outputs\apk\romanAppInternal-armeabi-v7a-debug.apk"

CDP_HOST_APK="D:\git_repos\cdp\samples\CDPHost\android\app\build\outputs\apk\cdphost-armv7-debug.apk"

XAMARIN_APP_APK="$XAMARIN_APP_WIN\ConnectedDevices.Xamarin.Droid.Sample\obj\Debug\android\bin\com.microsoft.romanapp.xamarin.MySigned.apk"
XAMARIN_APP_RELEASE_APK="$XAMARIN_APP_WIN\ConnectedDevices.Xamarin.Droid.Sample\bin\Release\com.microsoft.romanapp.xamarin-Signed.apk"
XAM_DLL_CSPROJ="$XAMARIN_PROJ_WIN\ConnectedDevices.Xamarin.Droid\ConnectedDevices.Xamarin.Droid.csproj"
XAM_APP_CSPROJ="$XAMARIN_APP_WIN\ConnectedDevices.Xamarin.Droid.Sample\ConnectedDevices.Xamarin.Droid.Sample.csproj"

# JNI building
CON_DEV_DIR="$CDP_ANDROID_SDK\3p\build\intermediates\classes\debug\com\microsoft\connecteddevices"
CDP_JNI_DIR="$CDP_ANDROID_SDK\jni"
JNI_CLASSPATH="$CDP_ANDROID_SDK\3p\build\intermediates\classes\debug;C:\Program Files (x86)\Android\android-sdk\platforms\android-22\android.jar"
JNI_CLASS="PlatformInternal"