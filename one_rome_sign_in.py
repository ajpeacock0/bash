import argparse
import subprocess
import time
from one_rome_coordinates import oneplus as co
from secrets import CDP_MSA as msaUsername
from secrets import CDP_MSA_PASS as msaPassword

ADB_TAP = "adb shell input tap {x} {y}"
ADB_SWIPE = "adb shell input swipe {x1} {y1} {x2} {y2} {duration}"
ADB_TEXT = "adb shell input text {text}"
ADB_OK = " adb shell input keyevent 66"


def __run_adb(adb_command):
    print("Running: [%s]" % adb_command)
    result = subprocess.call(adb_command, shell=True)
    assert result == 0


def __msa_accept():
    # Swipe down to see the YES/NO btns
    __run_adb(ADB_SWIPE.format(x1=300, y1=1500, x2=300, y2=500, duration=100))
    # Sleep to finish scrolling
    time.sleep(0.1)
    # Accept MSA access permissions
    __run_adb(ADB_TAP.format(x=co["accept_MSA_permissions"].x, y=co["accept_MSA_permissions"].y))
    # Wait for MSA permissions to finish
    time.sleep(1)


def __enter_creds(username, password):
    __run_adb(ADB_TEXT.format(text=username))
    __run_adb(ADB_OK)
    # Wait for password page to load
    time.sleep(1)
    __run_adb(ADB_TEXT.format(text=password))
    __run_adb(ADB_OK)
    # Wait for MSA permissions to load
    time.sleep(3)


def __rome_init_plat():
    # Click the tab open button
    __run_adb(ADB_TAP.format(x=co["pageMenu"].x, y=co["pageMenu"].y))
    # Click the "Platform" tab
    __run_adb(ADB_TAP.format(x=co["platformPage"].x, y=co["platformPage"].y))
    # Click the "Start" button
    __run_adb(ADB_TAP.format(x=co["initializeButton"].x, y=co["initializeButton"].y))
    # Wait for Init to complete
    time.sleep(1)


def __rome_sign_in(username=None, password=None):
    # Click the tab open button
    __run_adb(ADB_TAP.format(x=co["pageMenu"].x, y=co["pageMenu"].y))
    # Click the "Login" tab
    __run_adb(ADB_TAP.format(x=co["loginPage"].x, y=co["loginPage"].y))
    # Click the "SIGN IN" button
    __run_adb(ADB_TAP.format(x=co["signinButton"].x, y=co["signinButton"].y))
    # Wait for Web view to load
    time.sleep(5)
    # Enter the MSA credentials if specified
    if username is not None and password is not None:
        __enter_creds(username, password)
    # Click the "Accept" button
    __msa_accept()
    # Wait for MSA permissions to finish
    time.sleep(1)


def __start_rome_watcher():
    # Click the tab open button
    __run_adb(ADB_TAP.format(x=co["pageMenu"].x, y=co["pageMenu"].y))
    # Click the "RemoteSystemWatcher" tab
    __run_adb(ADB_TAP.format(x=co["watcherPage"].x, y=co["watcherPage"].y))
    # Click the "Start Watcher" button
    __run_adb(ADB_TAP.format(x=co["startWatcherButton"].x, y=co["startWatcherButton"].y))


def __start_rome_launch():
    # Click the tab open button
    __run_adb(ADB_TAP.format(x=co["pageMenu"].x, y=co["pageMenu"].y))
    # Click the "Launch" tab
    __run_adb(ADB_TAP.format(x=co["launchPage"].x, y=co["launchPage"].y))
    # Click the button to select system
    __run_adb(ADB_TAP.format(x=co["selectSystemButton"].x, y=co["selectSystemButton"].y))


def start_rome(args):
    # Wait for application to launch
    time.sleep(1)
    __rome_init_plat()
    if args.enter_creds:
        __rome_sign_in(msaUsername, msaPassword)
    else:
        __rome_sign_in()
    __start_rome_watcher()


def parse_args():
    """Parse arguments"""
    parser = argparse.ArgumentParser(description='Some description')
    # TODO: Handle the `notify` arg
    parser.add_argument(
        '-c', '--enter_creds', help='TODO: IMP - If the credentials should be entered. Use this on a fresh install / wiped cache', action='store_true')

    return parser.parse_args()


def main():
    """Main"""
    args = parse_args()

    start_rome(args)

    return 0


if __name__ == "__main__":
    exit(main())
