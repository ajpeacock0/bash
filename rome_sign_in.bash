#### Private Script Functions ####

_get_pas () { echo -n Password: && read -s pass && echo; }

_adb_enter_left() { _adb_ok; }

_adb_enter_right() { _adb_tab && _adb_ok; }

_rome_start ()
{
adb shell input tap 200 300 && # click the "Platform" tab
adb shell input tap 350 650 && # click the "Start" button
sleep 1 && # wait for Init to complete
adb shell input tap 100 150 && # click the tab open button
adb shell input tap 200 450 && # click the "Login" tab
adb shell input tap 300 1800 && # click the "SIGN IN" button
sleep 2 # wait for Web view to load;
}

_rome_start_watcher ()
{
sleep 0.5 && # wait for MSA permissions to finish
adb shell input tap 100 150 && # click the tab open button
adb shell input tap 200 750 && # click the "RemoteSystemWatcher" tab
adb shell input tap 350 550; # click the "Start Watcher" button
}

_msa_accept ()
{
sleep 2.5 && # wait for MSA permissions to load
adb shell input swipe 300 1500 300 500 100 && # swipe down to see the YES/NO btns
adb shell input tap 700 1400 && # accept MSA access permissions
sleep 1; # wait for MSA permissions to finish
}

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

enter_creds ()
{
_choose_adb_device $1 &&
_adb_input_text $CDP_MSA &&
_adb_ok && # enter the MSA
sleep 1 && # wait for password page to load
_adb_input_text $CDP_MSA_PASS &&
_adb_ok && # enter the pass
_msa_accept; # accept Microsoft's MSA permissions
}

rome_start ()
{
_rome_start && 
_msa_accept &&
_rome_start_watcher;
}

rome_sign_in ()
{
_rome_start && 
enter_creds &&
_rome_start_watcher;
}

# rome_start ()
# {
# close rome_in && launch rome_in &&
# adb shell input tap 500 200; # click at top of the screen. This ignores the HockeyApp update prompt, but leaves the permissions prompt
# _adb_enter_right && # deny update
# rome_sign_in;
# }