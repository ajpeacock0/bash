import argparse
import subprocess
import os
from secrets import HOME_IP as homeIp
from secrets import HOME_PORT as homePort


APP_NAME_KEYS = {
    "one_rome": "com.microsoft.oneRomanApp",
    "cdphost": "com.microsoft.cdp.cdphost",
    "tdd": "com.microsoft.tddrunner"
}

APP_DIR_NAME_KEYS = {
    "one_rome": "samples/oneromanapp",
    "cdphost": "samples/CDPHost",
    "tdd": "test/tdd/runners"
}

APP_TITLE_KEYS = {
    "one_rome": "oneRomanApp",
    "cdphost": "cdphost",
    "tdd": "tdd"
}

APP_MAIN_ACTIVITY_KEYS = {
    "one_rome": "MainActivity",
    "cdphost": "TODO",
    "tdd": "TddRunner"
}

ARCH = {
    "ARM": "armeabi-v7a",
    "X86": "x86"
}

FLAVOR = {
    "DEBUG": "debug",
    "RELEASE": "release"
}

ADB_CONNECTION_TYPE = {
    "VM": '-e',
    "USB": '-d'
}

APK_DIR = "{root}/{dir_name}/android/app/build/outputs/apk/{flavor}/{app_title}-{arch}-{flavor}.apk"


### ADB command strings ###

ADB_ROOT = "adb {connection_type} root"

# General app commands
APP_LAUNCH = "adb {connection_type} shell am start -S -N {debug_flag} {app_name}/.{main_activity}"
APP_CLOSE = "adb {connection_type} shell am force-stop {app_name}"
APP_NUKE = "adb {connection_type} shell pm clear {app_name}"
APP_INSTALL = "adb {connection_type} install -d -r {apk}"
APP_CLOSE_INSTALL = APP_CLOSE + " && " + APP_INSTALL
APP_UNINSTALL = "adb {connection_type} uninstall {app_name}"
APP_CLOSE_UNINSTALL = APP_CLOSE + " && " + APP_UNINSTALL

# TDD specific commands
TDD_LAUNCH = APP_LAUNCH + " --es name {tests} --ez trx true --ez log true --ei repeat {loop}"

# Log interaction commands
RM_LOG = "adb {connection_type} shell rm sdcard/Android/data/{app_name}/files/CDPTraces.log"
PULL_LOG = "adb {connection_type} pull sdcard/Android/data/{app_name}/files/CDPTraces.log CDPTraces_android.log"

# Utility commands
OS_VERSION = "adb {connection_type} shell getprop ro.build.version.release | tr -d \'\\r\'"
LIST_PACKAGES = "adb {connection_type} shell pm list packages -f | sed -e 's/.*=//' | sort"
LIST_APPS = "adb {connection_type} ls \"sdcard/Android/data\""
LIST_DEVICES = "adb devices | grep \"device$\" | sed 's/ *device//g'"
ADB_RESTART = "adb kill-server && sleep 1 && adb start-server"
ADB_CONNECT = " adb connect {ip}:{port}" + " && " + LIST_DEVICES
ADB_INPUT_TEXT = "adb {connection_type} shell input text {text}"
ADB_INPUT_POWER = " adb {connection_type} shell input keyevent 26"
ADB_INPUT_BACK = " adb {connection_type} shell input keyevent 3"
ADB_INPUT_OK = " adb {connection_type} shell input keyevent 66"
ADB_INPUT_TAB = " adb {connection_type} shell input keyevent 61"

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

    def __get_connection_type(self, args):
        if args.vm:
            return ADB_CONNECTION_TYPE["VM"]
        if args.usb:
            return ADB_CONNECTION_TYPE["USB"]
        return ''

    # Argument setup functions
    def __setup_install(self, subparsers, parent_parser):
        parser = subparsers.add_parser('install', help='TODO: Write help description', parents = [parent_parser])
        parser.add_argument('application_name', type=str, help='TODO: Write help description')
        parser.add_argument(
            '--root_dir', help='TODO: Write help description', default=os.getcwd())
        parser.add_argument(
            '-l', '--launch', help='Launch after installing the APK', action='store_true')

        flavor_group = parser.add_mutually_exclusive_group()
        flavor_group.add_argument('--debug', help='Install debug version of the APK', action='store_true')
        flavor_group.add_argument('--release', help='Install release version of the APK', action='store_true')

        arch_group = parser.add_mutually_exclusive_group()
        arch_group.add_argument('--arm', help='Install the ARM version of the APK', action='store_true')
        arch_group.add_argument('--x86', help='Install the x86 version of the APK', action='store_true')


    # TODO: Change this to be an argument to install
    def __setup_install_apk(self, subparsers, parent_parser):
        parser = subparsers.add_parser('install_apk', help='TODO: Write help description', parents = [parent_parser])
        parser.add_argument('apk_path', type=str, help='TODO: Write help description')
        parser.add_argument(
            '-l', '--launch', help='Launch after installing the APK', action='store_true')

    def __setup_launch(self, subparsers, parent_parser):
        parser = subparsers.add_parser('launch', help='Open given application', parents = [parent_parser])
        parser.add_argument('application_name', type=str, help='TODO: Write help description')
        parser.add_argument('-d', '--debug', help='TODO: THIS HAS NOT BEEN IMPLMENENTED', action='store_true')
        parser.add_argument('-c', '--close', help='TODO: THIS HAS NOT BEEN IMPLMENENTED', action='store_true')
    
    def __setup_close(self, subparsers, parent_parser):
        parser = subparsers.add_parser('close', help='Close given application', parents = [parent_parser])
        parser.add_argument('application_name', type=str, help='TODO: Write help description')
        parser.add_argument('-r', '--restart', help='TODO: THIS HAS NOT BEEN IMPLMENENTED', action='store_true')
    
    def __setup_nuke(self, subparsers, parent_parser):
        parser = subparsers.add_parser('nuke', help='Close app process and clear out all the stored data for given that app', parents = [parent_parser])
        parser.add_argument('application_name', type=str, help='TODO: Write help description')
    
    def __setup_uninstall(self, subparsers, parent_parser):
        parser = subparsers.add_parser('uninstall', help='TODO: Write help description', parents = [parent_parser])
        parser.add_argument('application_name', type=str, help='TODO: Write help description')

    def __setup_tdd(self, subparsers, parent_parser):
        parser = subparsers.add_parser('tdd', help='TODO: Write help description', parents = [parent_parser])
        parser.add_argument('--tests', type=str, default="ALL", help='Specify the tests to run. Omitting this will run all tests')
        parser.add_argument('-d', '--debug', help='Launch the app in debug mode to attach a debugger', action='store_true')
        parser.add_argument('-l', '--loop', type=int, default=1, help='Specifies the number of loops the UTs will do. Default = 1')

    def __setup_rm_log(self, subparsers, parent_parser):
        parser = subparsers.add_parser('rm_log', help='Delete the CDP log for the given app', parents = [parent_parser])
        parser.add_argument('application_name', type=str, help='TODO: Write help description')

    def __setup_pull_log(self, subparsers, parent_parser):
        parser = subparsers.add_parser('pull_log', help='Pull the CDP log for the given app', parents = [parent_parser])
        parser.add_argument('application_name', type=str, help='TODO: Write help description')
        parser.add_argument('-f', '--folder', help='Pull the entire CDP folder instead of just the log', action='store_true')

    def __setup_os_version(self, subparsers, parent_parser):
        parser = subparsers.add_parser('os_version', help='Get the OS version of the Android device', parents = [parent_parser])

    def __setup_ls(self, subparsers, parent_parser):
        parser = subparsers.add_parser('ls', help='Specify the type of object to list', parents = [parent_parser])
        parser.add_argument('ls_action', choices=('packages', 'apps', 'devices'))

    def __setup_restart(self, subparsers):
        parser = subparsers.add_parser('restart', help='Restart the ADB daemon')

    def __setup_connect(self, subparsers):
        parser = subparsers.add_parser('connect', help='TODO: Write help description')
        parser.add_argument('--ip', type=str, help='TODO: Write help description', default=homeIp)
        parser.add_argument('--port', type=str, help='TODO: Write help description. If you do not have a custom, enter the default of 5555', default=homePort)

    def __setup_input_text(self, subparsers):
        parser = subparsers.add_parser('input_text', help='Print the given text to the devices curser')
        parser.add_argument('text', type=str)

    # Action functions
    def install(self, args):
        apk_path = APK_DIR.format(root=args.root_dir, dir_name=APP_DIR_NAME_KEYS[args.application_name], app_title=APP_TITLE_KEYS[args.application_name], arch=self.__get_arch(args), flavor=self.__get_flavour(args));
        command = APP_CLOSE_INSTALL.format(connection_type=self.__get_connection_type(args), app_name=APP_NAME_KEYS[args.application_name], apk=apk_path)
        if args.launch:
            command += " && " + self.launch(args)
        return command

    def install_apk(self, args):
        command = APP_INSTALL.format(connection_type=self.__get_connection_type(args), apk=args.apk_path)
        if args.launch:
            command += " && " + self.launch(args)
        return command

    def launch(self, args):
        return APP_LAUNCH.format(connection_type=self.__get_connection_type(args), app_name=APP_NAME_KEYS[args.application_name], main_activity=APP_MAIN_ACTIVITY_KEYS[args.application_name], debug_flag='-D' if args.debug else '')

    def close(self, args):
        return APP_CLOSE.format(connection_type=self.__get_connection_type(args), app_name=APP_NAME_KEYS[args.application_name])

    def nuke(self, args):
        return APP_NUKE.format(connection_type=self.__get_connection_type(args), app_name=APP_NAME_KEYS[args.application_name])

    def uninstall(self, args):
        return APP_CLOSE_UNINSTALL.format(connection_type=self.__get_connection_type(args), app_name=APP_NAME_KEYS[args.application_name])

    def tdd(self, args):
        return TDD_LAUNCH.format(connection_type=self.__get_connection_type(args), app_name=APP_NAME_KEYS["tdd"], main_activity=APP_MAIN_ACTIVITY_KEYS["tdd"], tests=args.tests, loop=args.loop, debug_flag='-D' if args.debug else '')

    def rm_log(self, args):
        return RM_LOG.format(connection_type=self.__get_connection_type(args), app_name=APP_NAME_KEYS[args.application_name])

    def pull_log(self, args):
        return PULL_LOG.format(connection_type=self.__get_connection_type(args), app_name=APP_NAME_KEYS[args.application_name])

    def os_version(self, args):
        return OS_VERSION.format(connection_type=self.__get_connection_type(args))

    def ls(self, args):
        if args.ls_action == "packages":
            return LIST_PACKAGES.format(connection_type=self.__get_connection_type(args))
        if args.ls_action == "apps":
            return LIST_APPS.format(connection_type=self.__get_connection_type(args))
        if args.ls_action == "devices":
            return LIST_DEVICES.format(connection_type=self.__get_connection_type(args))

        return "echo \"This should not be possible with the mutually exclusive group\""

    def restart(self, args):
        return ADB_RESTART

    def connect(self, args):
        return ADB_CONNECT.format(ip=args.ip, port=args.port)

    def input_text(self, args):
        return ADB_INPUT_TEXT.format(text=args.text)

    def __init__(self):
        """Parse arguments"""
        parser = argparse.ArgumentParser(description='Some description')
        parser.add_argument('-v', '--verbose', help='Display the ADB commands used', action='store_true')
        subparsers = parser.add_subparsers(help='TODO: Write help description', dest='action')

        parent_parser = argparse.ArgumentParser(add_help=False)
        # parent_parser.add_argument('--vm', help='If the ADB connection should be attempted over a VM connection / IP connect', action='store_true')

        # TODO: Handle the `notify` arg
        connection_type_group = parent_parser.add_mutually_exclusive_group()
        connection_type_group.add_argument('--vm', help='If the ADB connection should be attempted over a VM/IP connectionconnect', action='store_true')
        connection_type_group.add_argument('--usb', help='If the ADB connection should be attempted over a usb connection', action='store_true')

        # General app
        self.__setup_install(subparsers, parent_parser)
        self.__setup_install_apk(subparsers, parent_parser)
        self.__setup_launch(subparsers, parent_parser)
        self.__setup_close(subparsers, parent_parser)
        self.__setup_nuke(subparsers, parent_parser)
        self.__setup_uninstall(subparsers, parent_parser)
        # TDD specific
        self.__setup_tdd(subparsers, parent_parser)
        # Log interaction
        self.__setup_rm_log(subparsers, parent_parser)
        self.__setup_pull_log(subparsers, parent_parser)
        # Utility
        self.__setup_os_version(subparsers, parent_parser)
        self.__setup_ls(subparsers, parent_parser)
        self.__setup_restart(subparsers)
        self.__setup_connect(subparsers)
        self.__setup_input_text(subparsers)

        args = parser.parse_args()

        # Feels like we are fighting with argparse by using adding parsers this way
        if args.action is None:
            print("No action given.", end=' ')
            parser.print_help()
            return

        try:
            adb_command = getattr(self, args.action)(args)
            if args.verbose:
                print("Running: ", adb_command)
            result = subprocess.call(adb_command, shell=True)
            assert result == 0
        except AttributeError:
            print("Given action " + args.action + " was not found.")


def main():
    """Main"""
    arg_parser = ArgParser()

    return 0


if __name__ == "__main__":
    exit(main())
