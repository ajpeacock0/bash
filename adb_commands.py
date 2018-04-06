import argparse
import os
import glob
import time
from secrets import HOME_IP as homeIp
from secrets import HOME_PORT as homePort
from adb_android import adb_android as adb

APP_NAME_KEYS = {
    "ora": "com.microsoft.oneRomanApp",
    "ora_test": "com.microsoft.oneRomanApp",
    "mmx": "com.microsoft.mmx.agentapp",
    "tdd": "com.microsoft.tddrunner",
    "graph": "com.microsoft.office365.connectmicrosoftgraph"
}

APP_DIR_NAME_KEYS = {
    "ora": "samples/oneromanapp/android/app/projects/full/build/outputs/apk",
    "ora_test": "samples/oneromanapp/android/app/projects/full/build/outputs/apk/androidTest",
    "mmx": "com.microsoft.mmx.agentapp",
    "tdd": "test/tdd/runners/android/app/build/outputs/apk"
}

APP_MAIN_ACTIVITY_KEYS = {
    "ora": "MainActivity",
    "tdd": "TddRunner",
    "mmx": "MainActivity",
    "graph": "ConnectActivity"
}

ARCH = {
    "ARM": "arm",  # previous value was "armeabi-v7a",
    "X86": "x86"
}

FLAVOR = {
    "DEBUG": "debug",
    "RELEASE": "release"
}

# ADB command strings
APK_DIR = "{root}/{dir_name}/{arch}/{flavor}"
CDP_SRC_FILES_PATH = "sdcard/Android/data/{app_name}/files"
CDP_DEST_FILES_NAME = "android_files"
CDP_SRC_LOG_NAME = "CDPTraces.log"
CDP_DEST_LOG_NAME = "CDPTraces_android.log"
TDD_FLAGS = "--es name {tests} --ez trx true --ez log true --ei repeat {loop}"

ADB_INSTALL_REPLACE_EXISTING_APP_FLAG = '-r'
ADB_INSTALL_ALLOW_DOWNGRADE_FLAG = '-d'
ADB_LAUNCH_STOP_FLAG = '-S'
ADB_LAUNCH_DEBUG_FLAG = '-D'
# Note: Only available on Android 7.0+ devices
ADB_LAUNCH_NATIVE_DEBUGGING_FLAG = '-N'

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

    def __get_debug_flag(self, args):
        if args.debug:
            return ADB_LAUNCH_DEBUG_FLAG
        return ''

    # There is something wrong with this. I had the issue where if I changed branches from task/xxx to task/xxx_p2 then new builds weren't being used
    def __find_most_recent_apk(self, searchDir):
        # Return the newest file under the given directory with the APK extension
        os.chdir(searchDir)
        most_recent_time = time.gmtime(0)
        most_recent_file = 'NO_FILE_FOUND'
        for file in glob.glob("*.apk"):
            mtime = time.gmtime(os.path.getmtime(file))
            if mtime > most_recent_time:
                most_recent_time
                most_recent_file = file
        return most_recent_file

    # Argument setup functions
    def __setup_install(self, subparsers, parent_parser):
        parser = subparsers.add_parser('install', help='Use a shortcut name to install the APK at its known location. For generic APKs, use `install_apk`', parents = [parent_parser])
        parser.add_argument('application_name', type=str, help='Shortcut name of the Android application')
        parser.add_argument('--root_dir', help='The root CDP directory to search for the APKs', default=os.getcwd())
        parser.add_argument('-l', '--launch', help='Launch after installing the APK', action='store_true')

        flavor_group = parser.add_mutually_exclusive_group()
        flavor_group.add_argument('--debug', help='Install debug version of the APK', action='store_true')
        flavor_group.add_argument('--release', help='Install release version of the APK', action='store_true')

        arch_group = parser.add_mutually_exclusive_group()
        arch_group.add_argument('--arm', help='Install the ARM version of the APK', action='store_true')
        arch_group.add_argument('--x86', help='Install the x86 version of the APK', action='store_true')

        parser.set_defaults(func=self.install)

    def __setup_install_apk(self, subparsers, parent_parser):
        parser = subparsers.add_parser('install_apk', help='Installs a specific apk by providing a direct path.', parents = [parent_parser])
        parser.add_argument('apk_path', type=str, help='Path to the APK.')
        parser.add_argument('-l', '--launch', help='Launch after installing the APK', action='store_true')

        parser.set_defaults(func=self.install_apk)

    def __setup_launch(self, subparsers, parent_parser):
        parser = subparsers.add_parser('launch', help='Open given application', parents = [parent_parser])
        parser.add_argument('application_name', type=str, help='Shortcut name of the Android application')
        parser.add_argument('-d', '--debug', help='Launch the application with the debug flag enabled so that it will wait for a debugger to be attached.', action='store_true')

        parser.set_defaults(func=self.launch)
    
    def __setup_close(self, subparsers, parent_parser):
        parser = subparsers.add_parser('close', help='Close given application', parents = [parent_parser])
        parser.add_argument('application_name', type=str, help='Shortcut name of the Android application')
        parser.add_argument('-r', '--restart', help='TODO: THIS HAS NOT BEEN IMPLMENENTED', action='store_true')

        parser.set_defaults(func=self.close)
    
    def __setup_nuke(self, subparsers, parent_parser):
        parser = subparsers.add_parser('nuke', help='Close app process and clear out all the stored data for given that app', parents = [parent_parser])
        parser.add_argument('application_name', type=str, help='Shortcut name of the Android application')

        parser.set_defaults(func=self.nuke)
    
    def __setup_uninstall(self, subparsers, parent_parser):
        parser = subparsers.add_parser('uninstall', help='Uninstalls the given known Android application', parents = [parent_parser])
        parser.add_argument('application_name', type=str, help='Shortcut name of the Android application')

        parser.set_defaults(func=self.uninstall)

    def __setup_test(self, subparsers, parent_parser):
        parser = subparsers.add_parser('test', help='Run all instrumented tests for the given application', parents = [parent_parser])
        parser.add_argument('application_name', type=str, help='Shortcut name of the Android application')
        parser.add_argument('--clazz', type=str, default=None, help='Filter tests to run to the given class')

        parser.set_defaults(func=self.test)

    def __setup_tdd(self, subparsers, parent_parser):
        parser = subparsers.add_parser('tdd', help='TODO: Write help description', parents = [parent_parser])
        parser.add_argument('--tests', type=str, default="ALL", help='Specify the tests to run. Omitting this will run all tests')
        parser.add_argument('-d', '--debug', help='Launch the app in debug mode to attach a debugger', action='store_true')
        parser.add_argument('-l', '--loop', type=int, default=1, help='Specifies the number of loops the UTs will do. Default = 1')

        parser.set_defaults(func=self.tdd)

    def __setup_rm_log(self, subparsers, parent_parser):
        parser = subparsers.add_parser('rm_log', help='Delete the CDP log for the given app', parents = [parent_parser])
        parser.add_argument('application_name', type=str, help='Shortcut name of the Android application')

        parser.set_defaults(func=self.rm_log)

    def __setup_pull_log(self, subparsers, parent_parser):
        parser = subparsers.add_parser('pull_log', help='Pull the CDP log for the given app', parents = [parent_parser])
        parser.add_argument('application_name', type=str, help='Shortcut name of the Android application')
        parser.add_argument('-d', '--directory', help='Pull the entire CDP directory instead of just the log', action='store_true')

        parser.set_defaults(func=self.pull_log)

    def __setup_os_version(self, subparsers, parent_parser):
        parser = subparsers.add_parser('os_version', help='Get the OS version of the Android device', parents = [parent_parser])

        parser.set_defaults(func=self.os_version)

    def __setup_packages(self, subparsers, parent_parser):
        parser = subparsers.add_parser('packages', help='Specify the type of object to list', parents = [parent_parser])

        parser.set_defaults(func=self.packages)

    def __setup_apps(self, subparsers, parent_parser):
        parser = subparsers.add_parser('apps', help='Specify the type of object to list', parents = [parent_parser])

        parser.set_defaults(func=self.apps)

    def __setup_devices(self, subparsers):
        parser = subparsers.add_parser('devices', help='Specify the type of object to list')

        parser.set_defaults(func=self.devices)

    def __setup_restart(self, subparsers):
        parser = subparsers.add_parser('restart', help='Restart the ADB daemon')

        parser.set_defaults(func=self.restart)

    def __setup_connect(self, subparsers):
        parser = subparsers.add_parser('connect', help='Connect ADB to the given device over TCP')
        parser.add_argument('--ip', type=str, help='IP address of the device', default=homeIp)
        parser.add_argument('--port', type=str, help='Port adb is listening for on the device. If you do not have a custom, enter the default of 5555', default=homePort)

        parser.set_defaults(func=self.connect)

    def __setup_input_text(self, subparsers, parent_parser):
        parser = subparsers.add_parser('input_text', help='Print the given text to the devices curser', parents = [parent_parser])
        parser.add_argument('text', type=str)

        parser.set_defaults(func=self.input_text)

    def __setup_bug_report(self, subparsers, parent_parser):
        parser = subparsers.add_parser('bug_report', help='Prints dumpsys, dumpstate, and logcat data to the screen, for the purposes of bug reporting', parents = [parent_parser])
        parser.add_argument('-f', '--file_name', type=str, default='android_dump.log')

        parser.set_defaults(func=self.bug_report)

    # Action functions
    def install(self, args):
        # Get the path of the APK from the given app name
        apk_dir = APK_DIR.format(root=args.root_dir, dir_name=APP_DIR_NAME_KEYS[args.application_name], arch=self.__get_arch(args), flavor=self.__get_flavour(args))

        # We close the application since installing an APK while the app is running can have negative affects. TODO: test if this is needed
        adb.close(APP_NAME_KEYS[args.application_name], device_indexes=args.select_device)
        adb.install(apk_dir+"/"+self.__find_most_recent_apk(apk_dir), [ADB_INSTALL_REPLACE_EXISTING_APP_FLAG, ADB_INSTALL_ALLOW_DOWNGRADE_FLAG], device_indexes=args.select_device)

        if args.launch:
            self.launch(args)

    def install_apk(self, args):
        adb.install(args.apk_path, ['-d', '-r'], device_indexes=args.select_device)
        if args.launch:
            self.launch(args)

    def launch(self, args):
        adb.launch(APP_NAME_KEYS[args.application_name], APP_MAIN_ACTIVITY_KEYS[args.application_name], [ADB_LAUNCH_STOP_FLAG, self.__get_debug_flag(args)], device_indexes=args.select_device)

    def close(self, args):
        adb.close(APP_NAME_KEYS[args.application_name], device_indexes=args.select_device)

    def nuke(self, args):
        adb.clear(APP_NAME_KEYS[args.application_name], device_indexes=args.select_device)

    def uninstall(self, args):
        adb.close(APP_NAME_KEYS[args.application_name], device_indexes=args.select_device)
        adb.uninstall(APP_NAME_KEYS[args.application_name], device_indexes=args.select_device)

    def test(self, args):
        application_name = "{}.test".format(APP_NAME_KEYS[args.application_name])
        # '-w' instructs ADB to wait until the instrumentation has completed before exiting.
        # '-r' instructs ADB to use raw output for the test run. This is required by the instrumentation parser.
        # '-e class' specifies that all tests in the specified class should be run. It's also possible to specify a method, in which case only that method in this class will be run.
        # '-e package' specifies that all test cases in the given package should be run. This may be different from the previously provided test app package.
        flags = ['-w', '-r']
        if args.clazz is not None:
            flags.append('-e class {}.{}'.format(APP_NAME_KEYS[args.application_name], args.clazz))

        adb.run_tests(application_name, flags, device_indexes=args.select_device)

    def tdd(self, args):
        adb.launch(APP_MAIN_ACTIVITY_KEYS["tdd"], APP_MAIN_ACTIVITY_KEYS["tdd"], [ADB_LAUNCH_STOP_FLAG, self.__get_debug_flag(args), TDD_FLAGS.format(tests=args.tests, loop=args.loop)], device_indexes=args.select_device)

    def rm_log(self, args):
        adb.rm(CDP_SRC_FILES_PATH.format(app_name=APP_NAME_KEYS[args.application_name])+'/'+CDP_SRC_LOG_NAME, device_indexes=args.select_device)

    def pull_log(self, args):
        src = CDP_SRC_FILES_PATH.format(app_name=APP_NAME_KEYS[args.application_name])
        dest = CDP_DEST_FILES_NAME
        if not args.directory:
            src = src+'/'+CDP_SRC_LOG_NAME
            dest = CDP_DEST_LOG_NAME

        adb.pull(src, dest, device_indexes=args.select_device)

    def os_version(self, args):
        adb.os_version()

    def packages(self, args):
        adb.packages()

    def apps(self, args):
        adb.apps()

    def devices(self, args):
        adb.devices()

    def restart(self, args):
        adb.kill_server()
        # The sleep is required as kill_server is a async operation, but returns
        # before the operation has fully completed. We sleep to ensure the ADB 
        # daemon is fully killed before starting it.
        time.sleep(0.1)
        adb.start_server()

    def connect(self, args):
        adb.connect(args.ip, args.port)
        adb.devices()

    def input_text(self, args):
        adb.input_text(args.text, device_indexes=args.select_device)

    def bug_report(self, args):
        adb.bugreport(device_indexes=args.select_device)

    def __init__(self):
        """Parse arguments"""
        parser = argparse.ArgumentParser(description='Some description')
        parser.add_argument('-q', '--quiet', help='Do not display the ADB commands used', action='store_true')
        subparsers = parser.add_subparsers()

        target_device_parser = argparse.ArgumentParser(add_help=False)

        connection_type_group = target_device_parser.add_mutually_exclusive_group()
        connection_type_group.add_argument('-s','--select_device', action='append', type=int, default=None, help='Select the device to install the APK in the form of a list')

        # General app
        self.__setup_install(subparsers, target_device_parser)
        self.__setup_install_apk(subparsers, target_device_parser)
        self.__setup_launch(subparsers, target_device_parser)
        self.__setup_close(subparsers, target_device_parser)
        self.__setup_nuke(subparsers, target_device_parser)
        self.__setup_uninstall(subparsers, target_device_parser)
        self.__setup_test(subparsers, target_device_parser)
        # TDD specific
        self.__setup_tdd(subparsers, target_device_parser)
        # Log interaction
        self.__setup_rm_log(subparsers, target_device_parser)
        self.__setup_pull_log(subparsers, target_device_parser)
        # Utility
        self.__setup_os_version(subparsers, target_device_parser)
        self.__setup_packages(subparsers, target_device_parser)
        self.__setup_apps(subparsers, target_device_parser)
        self.__setup_devices(subparsers)
        self.__setup_restart(subparsers)
        self.__setup_connect(subparsers)
        self.__setup_input_text(subparsers, target_device_parser)
        self.__setup_bug_report(subparsers, target_device_parser)

        args = parser.parse_args()

        try:
            args.func(args)
        except AttributeError:
            print("Given action was not found.")


def main():
    """Main"""
    arg_parser = ArgParser()

    return 0


if __name__ == "__main__":
    exit(main())
