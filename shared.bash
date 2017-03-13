#### CDP ENV VARS ####

# Disks
C="/cygdrive/c"; export C
L="/cygdrive/l"; export L
F="/cygdrive/f"; export F
Z="//anpea-dev/c$"; export Z
X="/cygdrive/x"; export X

# CDP directories
CDP_1="$C/git_repos/cdp"
CDP_2="$C/git_repos/cdp_2"
CDP_MASTER="$C/git_repos/cdp_master"

CYGWIN="$C/cygwin64/home/anpea"
CYGWIN_WIN="C:/cygwin64/home/anpea"

# Application directories
ADB="$C/tools/adt-bundle-windows-x86_64-20140702/sdk/platform-tools/adb"
# NOTE: Due to the spaces in the path and the difference between aliases
# and functions, two seperate variables are required
SUBL_ALIAS="$C/Program\ Files/Sublime\ Text\ 3/subl.exe"
SUBL_FUNC="$C/Program Files/Sublime Text 3/subl.exe"

# Note files directories
WORK="$C/work_files"
WORK_WIN="C:/work_files"
