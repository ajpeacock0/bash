#### Private Script Functions ####

_get_pas () { echo -n Password: && read -s pass && echo; }

_adb_enter_left() { _adb_ok; }

_adb_enter_right() { _adb_tab && _adb_ok; }

#### Public Script Function ####

home_sign_in ()
{
_get_pas &&
adb shell input tap 555 1800 && # sign in with MSA btn
sleep 2 && # wait for Web view to load
_adb_input_text $MSA &&
_adb_ok && # enter the MSA
sleep 1 && # wait for password page to load
_adb_input_text "$pass" &&
_adb_ok; # enter the pass
}

msa_accept ()
{
adb shell input swipe 300 1500 300 500 100 && # swipe down to see the YES/NO btns
adb shell input tap 350 1400; # accept MSA access permissions
}

enter_creds ()
{
_choose_adb_device $1 &&
_adb_input_text $CDP_MSA &&
_adb_ok && # enter the MSA
sleep 1 && # wait for password page to load
_adb_input_text $CDP_MSA_PASS &&
_adb_ok && # enter the pass
sleep 3 && # wait for MSA permissions to load
msa_accept; # accept Microsoft's MSA permissions
}

rome_sign_in ()
{
adb shell input tap 300 1800 && # sign in with MSA btn
sleep 2 && # wait for Web view to load
enter_creds;
}

rome_start ()
{
close rome_in && launch rome_in &&
adb shell input tap 500 200; # click at top of the screen. This ignores the HockeyApp update prompt, but leaves the permissions prompt
_adb_enter_right && # deny update
rome_sign_in;
}