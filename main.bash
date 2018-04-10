source "${HOME}/variables.bash"

if [ -f "${HOME}/secrets.bash" ]; then
  source "${HOME}/secrets.bash"
fi

source "${HOME}/general.bash"

source "${HOME}/git.bash"

source "${HOME}/android.bash"

source "${HOME}/navigation.bash"

if [ -f "${HOME}/specific.bash" ]; then
  source "${HOME}/specific.bash"
fi

if [ -f "${HOME}/scripts.bash" ]; then
  source "${HOME}/scripts.bash"
fi