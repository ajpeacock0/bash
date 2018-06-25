import argparse
import subprocess
import os
import pprint

BUILD_KEYS = {
    # Converged SDK
    "conv": "connecteddevices-sdk",
    # OneRomanApp
    "ora": "oneRomanApp",
    "ora_activities": "oneRomanApp-activities",
    "ora_relay": "oneRomanApp-relay",
    # WNS Ping Test Application
    "wnsping": "wnspingtest",
    # CDP Host
    "cdphost": "cdphost",
    # TDD Runner
    "tdd": "tdd"
}

CLEAN_KEYS = {
    # Converged SDK
    "conv": "sdk/converged/projections/android/build",
    # OneRomanApp
    "ora": "samples/oneromanapp/android/app/projects/full/build",
    "ora_activities": "samples/oneromanapp/android/app/projects/activities/build",
    "ora_relay": "samples/oneromanapp/android/app/projects/relay/build",
    # WNS Ping Test Application
    "wnsping": "samples/wnspingtest/app/build",
    # CDP Host
    "cdphost": "samples/CDPHost/android/app/build",
    # TDD Runner
    "tdd": "test/tdd/runners/android/app/build"
}

FLAVOR = {
    "DEBUG": "debug",
    "RELEASE": "release"
}

ARCH = {
    "ARM": "arm",
    "X86": "x86"
}

GRADLEW_COMMAND = "{root}\gradlew :{task}:assemble{arch}{type}"
GRADLEW_TEST_COMMAND = "{root}\gradlew :sdk_test:connected{arch}{type}AndroidTest -PinstrumentedTestBuildType={type}"
GRADLEW_BUILD_ONE_ROMANAPP_TEST_COMMAND = "{root}\gradlew :oneRomanApp:assemble{arch}{type}AndroidTest"
GRADLEW_BUILD_AND_RUN_ONE_ROMANAPP_TEST_COMMAND = "{root}\gradlew :oneRomanApp:connected{arch}{type}AndroidTest"

# $adbTestFilter = "-e package com.microsoft.connecteddevices"
# if ((-not ([string]::IsNullOrEmpty($SdkTestFilter)))) {
#     $adbTestFilter = "-e class $SdkTestFilter"
# }

# $adbOutput = RunAdb shell am instrument -w -r $adbTestFilter com.microsoft.connecteddevices.test/android.support.test.runner.AndroidJUnitRunner

CLEAN_COMMAND = "rm -rf {root}/{build_dir}"

class ArgParser:
    # Utility functions
    def __get_flavour(self, args):
        if args.debug:
            return FLAVOR["DEBUG"]
        if args.release:
            return FLAVOR["RELEASE"]
        # Return default value of debug
        return FLAVOR["DEBUG"]

    def __get_arch(self, args):
        if args.arm:
            return ARCH["ARM"]
        if args.x86:
            return ARCH["X86"]
        # Return default value of arm
        return ARCH["ARM"]

    # Argument setup functions
    def __setup_build(self, subparsers, parent_parser):
        parser = subparsers.add_parser('build', help='Build the given task.', parents = [parent_parser])
        # TODO: Handle the `notify` arg
        parser.add_argument(
            '-n', '--notify', help='If a notification should be sent on build completion. NOTE: This has note been enabled yet', action='store_true')
        parser.add_argument(
            'build_task', help='The task to run. The following are the valid tasks' + pprint.pformat(BUILD_KEYS.keys()))

        flavor_group = parser.add_mutually_exclusive_group()
        flavor_group.add_argument('--debug', help='Install debug version of the APK', action='store_true')
        flavor_group.add_argument('--release', help='Install release version of the APK', action='store_true')

        arch_group = parser.add_mutually_exclusive_group()
        arch_group.add_argument('--arm', help='Install the ARM version of the APK', action='store_true')
        arch_group.add_argument('--x86', help='Install the x86 version of the APK', action='store_true')
        
        parser.set_defaults(func=self.build)

    def __setup_clean(self, subparsers, parent_parser):
        parser = subparsers.add_parser('clean', help='Clean the given task\'s build directory.', parents = [parent_parser])
        parser.add_argument(
            'build_task', help='The task to run. The following are the valid tasks' + pprint.pformat(BUILD_KEYS.keys()))

        parser.set_defaults(func=self.clean)

    # Action functions
    def build(self, args):
        if args.build_task == "sdk_test":
            return GRADLEW_TEST_COMMAND.format(root=args.root_dir, arch=self.__get_arch(args), type=self.__get_flavour(args))
        if args.build_task == "ora_test":
            return GRADLEW_BUILD_ONE_ROMANAPP_TEST_COMMAND.format(root=args.root_dir, arch=self.__get_arch(args), type=self.__get_flavour(args))
        return GRADLEW_COMMAND.format(root=args.root_dir, task=BUILD_KEYS[args.build_task], type=self.__get_flavour(args), arch=self.__get_arch(args))
        
    def clean(self, args):
        return CLEAN_COMMAND.format(root=args.root_dir, build_dir=CLEAN_KEYS[args.build_task])

    def __init__(self):
        """Parse arguments"""
        parser = argparse.ArgumentParser(description='Some description')
        parser.add_argument('-q', '--quiet', help='Do not display the gradle command used', action='store_true')
        subparsers = parser.add_subparsers()

        parent_parser = argparse.ArgumentParser(add_help=False)
        parent_parser.add_argument('-rd', '--root_dir', help='The root directory where gradlew is located. Default is the current directory', default=os.getcwd())

        # General app
        self.__setup_build(subparsers, parent_parser)
        self.__setup_clean(subparsers, parent_parser)

        args = parser.parse_args()

        try:
            command = args.func(args)
            if args.quiet is not True:
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

# _javap () { javap -classpath $CLASSES_JAR "com.microsoft.connecteddevices.$1"; }

# #### Building Android - Public Functions ####

# # build_in() { build $1 && adb_in $1 $2; }

# # Removes all files under build dirs

# build_jni() { _execute _build_jni jni_keys $1; }
