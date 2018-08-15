# ADB Commands shortcut
ac () { python $ANDROID_SCRIPTS_WIN\\adb_commands.py $@ 2>&1; }

# Gradle commands shortcut
gdl() { python $ANDROID_SCRIPTS_WIN\\gradle.py $@ 2>&1; }

# Install the app's APK using ADB
adb_in() { python $ANDROID_SCRIPTS_WIN\\adb_commands.py install --launch $@ 2>&1; }

# Shortcut for launching an application
launch() { python $ANDROID_SCRIPTS_WIN\\adb_commands.py launch $@ 2>&1; }

# OneRomanApp sign in / credential shortcut
ora () { python $ANDROID_SCRIPTS_WIN\\one_rome_sign_in.py $@ 2>&1; }

# View logcat though a better view - https://github.com/JakeWharton/pidcat
logcat () { python "$D_WIN\git_repos\pidcat\pidcat.py" $@; }

# Build gradle task
build() { python $ANDROID_SCRIPTS_WIN\\gradle.py $@ 2>&1; }

# Removes all files under build dirs
clean() { python $ANDROID_SCRIPTS_WIN\\clean_build.py $@ 2>&1; }

# Run the given TDD tests
tdd_run() { python $ANDROID_SCRIPTS_WIN\\adb_commands.py tdd --tests $@ 2>&1; }

# Clean, build and install that task
build_in() { build $1 && adb_in $@; }

# Build OneRomanApp Tests
bot() { python $ANDROID_SCRIPTS_WIN\\build_ora_test.py $@ 2>&1; }

# Run OneRomanApp Tests
rot() { python $ANDROID_SCRIPTS_WIN\\run_ora_test.py $@ 2>&1; }

# Update the CDPGlobalSettings.cdp to allow connections from RomeFiddler
fiddler_enable() { python $ANDROID_SCRIPTS_WIN\\rome_fiddler_enable.py $@ 2>&1; }
