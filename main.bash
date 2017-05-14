source "${HOME}/variables.bash"

source "${HOME}/general.bash"

source "${HOME}/git.bash"

source "${HOME}/android.bash"

if [ -f "${HOME}/specific.bash" ]; then
  source "${HOME}/specific.bash"
fi
