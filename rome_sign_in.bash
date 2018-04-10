#### Private Script Functions ####

_get_pas () { echo -n Password: && read -s pass && echo; }

_adb_enter_left() { _adb_ok; }

_adb_enter_right() { _adb_tab && _adb_ok; }

#### Public Script Function ####

rome_sign_in ()
{
close rome_in && launch rome_in &&
adb shell input tap 500 200; # click at top of the screen. This ignores the HockeyApp update prompt, but leaves the permissions prompt
_adb_enter_right && # deny update
_get_pas &&
adb shell input tap 555 1800 && # sign in with MSA btn
sleep 2 && # wait for Web view to load
_adb_input_text $MSA &&
_adb_ok && # enter the MSA
sleep 1 && # wait for password page to load
_adb_input_text "$pass" &&
_adb_ok && # enter the pass
adb shell input swipe 300 1500 300 500 100 && # swipe down to see the YES/NO btns
adb shell input tap 350 1400; # accept MSA access permissions
}