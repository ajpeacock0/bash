import argparse
import time
from adb_android import adb_android as adb
from one_rome_coordinates import oneplus as co
from secrets import CDP_MSA as msaUsername
from secrets import CDP_MSA_PASS as msaPassword


ADB_KEY_EVENT_OK = "66"
ADB_KEY_EVENT_BACK = "3"
ADB_KEY_EVENT_POWER = "26"
ADB_KEY_EVENT_TAB = "61"


def __msa_accept(device_indexes):
    # Swipe down to see the YES/NO btns
    adb.input_swipe(300, 1500, 300, 500, 100, device_indexes)
    # Sleep to finish scrolling
    time.sleep(0.1)
    # Accept MSA access permissions
    adb.input_tap(co["accept_MSA_permissions"].x, co["accept_MSA_permissions"].y, device_indexes)
    # Wait for MSA permissions to finish
    time.sleep(1)


def __enter_creds(username, password, device_indexes):
    adb.input_text(username, device_indexes)
    adb.input_keyevent(ADB_KEY_EVENT_OK, device_indexes)
    # Wait for password page to load
    time.sleep(1)
    adb.input_text(password, device_indexes)
    adb.input_keyevent(ADB_KEY_EVENT_OK, device_indexes)
    # Wait for MSA permissions to load
    time.sleep(3)


def __rome_init_plat(device_indexes):
    # Click the tab open button
    adb.input_tap(co["pageMenu"].x, co["pageMenu"].y, device_indexes)
    # Click the "Platform" tab
    adb.input_tap(co["platformPage"].x, co["platformPage"].y, device_indexes)
    # Click the "Start" button
    adb.input_tap(co["initializeButton"].x, co["initializeButton"].y, device_indexes)
    # Wait for Init to complete
    time.sleep(1)


def __rome_sign_in(username=None, password=None, device_indexes=None):
    # Click the tab open button
    adb.input_tap(co["pageMenu"].x, co["pageMenu"].y, device_indexes)
    # Click the "Login" tab
    adb.input_tap(co["loginPage"].x, co["loginPage"].y, device_indexes)
    # Click the "SIGN IN" button
    adb.input_tap(co["signinButton"].x, co["signinButton"].y, device_indexes)
    # Wait for Web view to load
    time.sleep(5)
    # Enter the MSA credentials if specified
    if username is not None and password is not None:
        __enter_creds(username, password)
    # Click the "Accept" button
    __msa_accept(device_indexes)
    # Wait for MSA permissions to finish
    time.sleep(1)


def __start_rome_watcher(device_indexes):
    # Click the tab open button
    adb.input_tap(co["pageMenu"].x, co["pageMenu"].y, device_indexes)
    # Click the "RemoteSystemWatcher" tab
    adb.input_tap(co["watcherPage"].x, co["watcherPage"].y, device_indexes)
    # Click the "Start Watcher" button
    adb.input_tap(co["startWatcherButton"].x, co["startWatcherButton"].y, device_indexes)


def __start_rome_launch(device_indexes):
    # Click the tab open button
    adb.input_tap(co["pageMenu"].x, co["pageMenu"].y, device_indexes)
    # Click the "Launch" tab
    adb.input_tap(co["launchPage"].x, co["launchPage"].y, device_indexes)
    # Click the button to select system
    adb.input_tap(co["selectSystemButton"].x, co["selectSystemButton"].y, device_indexes)


def start_rome(enter_creds, select_device):
    # Wait for application to launch
    time.sleep(1)
    __rome_init_plat(device_indexes=select_device)
    __rome_sign_in(device_indexes=select_device)
    __start_rome_watcher(device_indexes=select_device)


def parse_args():
    """Parse arguments"""
    parser = argparse.ArgumentParser(description='Some description')
    # TODO: Handle the `notify` arg
    parser.add_argument(
        '-c', '--enter_creds', help='TODO: IMP - If the credentials should be entered. Use this on a fresh install / wiped cache', action='store_true')

    target_group = parser.add_mutually_exclusive_group()
    target_group.add_argument('-s','--select_device', action='append', type=int, default=None, help='Select the device to install the APK in the form of a list')

    return parser.parse_args()


def main():
    """Main"""
    args = parse_args()

    if args.enter_creds:
        __enter_creds(msaUsername, msaPassword, device_indexes=args.select_device)
    else:
        start_rome(args.select_device)


    return 0


if __name__ == "__main__":
    exit(main())
