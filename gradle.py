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


    return parser.parse_args()

GRADLEW_COMMAND = "{root}\gradlew :{task}:assemble{type} -PabiToBuild={arch}"
GRADLEW_TEST_COMMAND="{root}\gradlew :sdk_converged:assembleDebug :sdk_test:connected{type}AndroidTest -PinstrumentedTestBuildType={type}"

# def __get_flavour(self, args):
#     return 'Release' if args.release else 'Debug'

FLAVOR = {
    "DEBUG": "debug",
    "RELEASE": "release"
}

class ArgParser:
    # Utility functions
    def __get_flavour(self, args):
        if args.debug:
            return FLAVOR["DEBUG"]
        if args.release:
            return FLAVOR["RELEASE"]
        # Return default value of debug
        return FLAVOR["DEBUG"]

    # Argument setup functions
    def __setup_build(self, subparsers, parent_parser):
        parser = subparsers.add_parser('build', help='Build the given task.', parents = [parent_parser])
        # TODO: Handle the `notify` arg
        parser.add_argument(
            '-n', '--notify', help='If a notification should be sent on build completion. NOTE: This has note been enabled yet', action='store_true')
        parser.add_argument(
            '--release', help='If a notification should be sent on build completion', action='store_true')
        parser.add_argument(
            '--x86', help='If a notification should be sent on build completion', action='store_true')
        parser.add_argument(
            'build_task', help='The task to run. The following are the valid tasks' + pprint.pformat(BUILD_KEYS.keys()))

        parser.set_defaults(func=self.build)

    # Action functions
    def build(self, args):
        if args.build_task == "sdk_test":
            return GRADLEW_TEST_COMMAND.format(root=args.root_dir, type=self.__get_flavour(args))
        return GRADLEW_COMMAND.format(root=args.root_dir, task=BUILD_KEYS[args.build_task], type='Release' if args.release else 'Debug', arch='x86' if args.x86 else 'armeabi-v7a')
        

    def __init__(self):
        """Parse arguments"""
        parser = argparse.ArgumentParser(description='Some description')
        parser.add_argument('-v', '--verbose', help='Display the ADB commands used', action='store_true')
        subparsers = parser.add_subparsers()

        parent_parser = argparse.ArgumentParser(add_help=False)
        parent_parser.add_argument('-rd', '--root_dir', help='The root directory where gradlew is located. Default is the current directory', default=os.getcwd())

        # General app
        self.__setup_build(subparsers, parent_parser)

        args = parser.parse_args()

        try:
            command = args.func(args)
            if args.verbose:
                print("Running: ", command)
            result = subprocess.call(command, shell=True)
            assert result == 0
        except AttributeError:
            print("Given action " + args.cmd_action + " was not found.")

def main():
    """Main"""
    arg_parser = ArgParser()

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
