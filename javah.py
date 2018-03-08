import argparse
import subprocess
import os
import pprint

DIR_KEYS = {
    "dev": "{root}/sdk/converged/projections/android/build/intermediates/classes/{arch}/{type}/com/microsoft/connecteddevices",
    "test": "{root}/test/sdk/android/build/intermediates/classes/androidTest/{arch}/{type}/com/microsoft/connecteddevices"
}

FLAVOR = {
    "DEBUG": "debug",
    "RELEASE": "release"
}

ARCH = {
    "ARM": "arm",
    "X86": "x86"
}

CDP_JNI_DIR = "{root}/sdk/converged/projections/android/src/jni"

JNI_CLASSPATH = "{root}/sdk/converged/projections/android/build/intermediates/classes/{arch}/{type};C:/Program Files (x86)/Android/android-sdk/platforms/android-22/android.jar"
BUILD_JNI = "pushd {class_dir} && javah -v -classpath {class_path} com.microsoft.connecteddevices.{name} && cp {class_dir}\com_microsoft_connecteddevices_{name}.h {jni_dir}\com_microsoft_connecteddevices_{name}.h && popd"

"C:\Program Files\Java\jdk1.8.0_121\bin\javah.exe" -v -classpath "{root}\test\sdk\android\build\intermediates\classes\androidTest\debug\;{root}\sdk\converged\projections\android\build\intermediates\classes\debug;C:\Program Files (x86)\Android\android-sdk\platforms\android-22\android.jar" com.microsoft.connecteddevices.AppServiceConnectionTest

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
    def __setup_javah(self, subparsers, parent_parser):
        parser = subparsers.add_parser('javah', help='Build the given task.', parents=[parent_parser])
        parser.add_argument(
            'file_name', help='The name of the class to build the JNI header from.')
        parser.add_argument(
            'location', help='The directory the class is in. The following are the valid dirs' + pprint.pformat(DIR_KEYS.keys()))

        flavor_group = parser.add_mutually_exclusive_group()
        flavor_group.add_argument('--debug', help='Look for the java class in the debug version of the path', action='store_true')
        flavor_group.add_argument('--release', help='Look for the java class in the release version of the path', action='store_true')

        arch_group = parser.add_mutually_exclusive_group()
        arch_group.add_argument('--arm', help='Look for the java class in the ARM version of the path', action='store_true')
        arch_group.add_argument('--x86', help='Look for the java class in the x86 version of the path', action='store_true')
        
        parser.set_defaults(func=self.javah)

    # Action functions
    def javah(self, args):
        my_class_dir = DIR_KEYS[args.location].format(root=args.root_dir, arch=self.__get_arch(args), type=self.__get_flavour(args))
        my_class_path = JNI_CLASSPATH.format(root=args.root_dir, arch=self.__get_arch(args), type=self.__get_flavour(args))
        my_jni_dir = CDP_JNI_DIR.format(root=args.root_dir)
        return BUILD_JNI.format(name=args.file_name, class_path=my_class_path, class_dir=my_class_dir, jni_dir=my_jni_dir)
        
    def __init__(self):
        """Parse arguments"""
        parser = argparse.ArgumentParser(description='Some description')
        parser.add_argument('-v', '--verbose', help='Display the javah command used', action='store_true')
        subparsers = parser.add_subparsers()

        parent_parser = argparse.ArgumentParser(add_help=False)
        parent_parser.add_argument('-rd', '--root_dir', help='The root directory of the project. Default is the current directory', default=os.getcwd())

        # General app
        self.__setup_javah(subparsers, parent_parser)

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
