import argparse
import subprocess
import os
import shutil
import pprint

BUILD_KEYS = {
    # Converged SDK
    "conv" : "sdk_converged",
    # OneRomanApp
    "one_rome" : "oneRomanApp",
    # WNS Ping Test Application
    "wnsping" : "wnspingtest",
    # CDP Host
    "cdphost" : "cdphost",
    # TDD Runner
    "tdd" : "tdd"
}

def parse_args():
    """Parse arguments"""
    parser = argparse.ArgumentParser(description='Some description')
    # TODO: Handle the `notify` arg
    parser.add_argument(
        '-n, --notify', help='If a notification should be sent on build completion', action='store_true')
    parser.add_argument(
        '--release', help='If a notification should be sent on build completion', action='store_true')
    parser.add_argument(
        '--x86', help='If a notification should be sent on build completion', action='store_true')
    parser.add_argument(
        '--root_dir', help='If a notification should be sent on build completion', default=os.getcwd())
    parser.add_argument(
        'build_task', help='The task to run. The following are the valid tasks' + pprint.pformat(BUILD_KEYS.keys()))

    return parser.parse_args()

GRADLEW_COMMAND = "{root}\gradlew :{task}:assemble{type} -PabiToBuild={arch}"
GRADLEW_TEST_COMMAND="{root}\gradlew :sdk_converged:assembleDebug :sdk_test:connected{type}AndroidTest -PinstrumentedTestBuildType={type_lower}"

# def __get_flavour(self, args):
#     return 'Release' if args.release else 'Debug'

def main():
    """Main"""
    args = parse_args()

    if args.build_task == "sdk_test":
	    gradlew_command = GRADLEW_TEST_COMMAND.format(root=args.root_dir, type='Release' if args.release else 'Debug', type_lower='release' if args.release else 'debug')
    else:
        gradlew_command = GRADLEW_COMMAND.format(root=args.root_dir, task=BUILD_KEYS[args.build_task], type='Release' if args.release else 'Debug', arch='x86' if args.x86 else 'armeabi-v7a')

    print("Running: ", gradlew_command)
    result = subprocess.call(gradlew_command, shell=True)
    assert result == 0

    return 0

if __name__ == "__main__":
    exit(main())

# #### Building Android - Private Functions ####

# _gradlew () { dos2unix gradlew && $GRADLEW $1; }

# _clean () {  rm -rf $1; }

# _javap () { javap -classpath $CLASSES_JAR "com.microsoft.connecteddevices.$1"; }

# _build_jni () { cd "$CON_DEV_DIR" && "$JAVAH" -v -classpath "$JNI_CLASSPATH" com.microsoft.connecteddevices.$1 && cp "$CON_DEV_DIR\com_microsoft_connecteddevices_$1.h" "$CDP_JNI_DIR\com_microsoft_connecteddevices_$1.h"; }

# _build_jni_test () { cd "$CON_TEST_DIR" && "$JAVAH" -v -classpath "$JNI_CLASSPATH" com.microsoft.connecteddevices.$1 && cp "$CON_TEST_DIR\com_microsoft_connecteddevices_$1.h" "$CDP_JNI_DIR\com_microsoft_connecteddevices_$1.h"; }

# #### Building Android - Public Functions ####

# # build_in() { build $1 && adb_in $1 $2; }

# # Removes all files under build dirs
# clean() { _execute _clean clean_keys $1; }

# build_jni() { _execute _build_jni jni_keys $1; }
