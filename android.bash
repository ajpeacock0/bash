# ADB Commands shortcut
ac () { python $MY_HOME_WIN\\adb_commands.py $@ 2>&1; }

# Gradle commands shortcut
gdl() { python $MY_HOME_WIN\\gradle.py $@ --root_dir="$CURR_CDP_WIN" 2>&1; }

# Install the app's APK using ADB
adb_in() { python $MY_HOME_WIN\\adb_commands.py install --root_dir="$CURR_CDP_WIN" --launch $@ 2>&1; }

# Shortcut for launching an application
launch() { python $MY_HOME_WIN\\adb_commands.py launch $@ 2>&1; }

# OneRomanApp sign in / credential shortcut
ora () { python $MY_HOME_WIN\\one_rome_sign_in.py $@ 2>&1; }

# View logcat though a better view - https://github.com/JakeWharton/pidcat
logcat () { python "$D_WIN\git_repos\pidcat\pidcat.py" $@; }

# Build gradle task
build() { python $MY_HOME_WIN\\gradle.py build --root_dir="$CURR_CDP_WIN" $@ 2>&1; }

# Removes all files under build dirs
clean() { python $MY_HOME_WIN\\gradle.py clean --root_dir="$CURR_CDP_WIN" $@ 2>&1; }

# Run the given TDD tests
tdd_run() { python $MY_HOME_WIN\\adb_commands.py tdd --tests $@ 2>&1; }

# Clean, build and install that task
build_in() { build $1 && adb_in $@; }

# one_rome_test. If there are any changes to the app itself, you need to generate the APK seperatley. This is because a new ORA APK is not generated with `build one_rome_test`
build_test() { build ora && build ora_test && ac install ora $@ && ac install ora_test $@ 2>&1; }