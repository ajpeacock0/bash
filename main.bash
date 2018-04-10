if [ -f "${SOURCES}/variables.bash" ]; then
  source "${SOURCES}/variables.bash"
fi

if [ -f "${SOURCES}/secrets.bash" ]; then
  source "${SOURCES}/secrets.bash"
fi

if [ -f "${SOURCES}/general.bash" ]; then
  source "${SOURCES}/general.bash"
fi

if [ -f "${SOURCES}/git.bash" ]; then
  source "${SOURCES}/git.bash"
fi

if [ -f "${SOURCES}/android.bash" ]; then
  source "${SOURCES}/android.bash"
fi

if [ -f "${SOURCES}/navigation.bash" ]; then
  source "${SOURCES}/navigation.bash"
fi

if [ -f "${SOURCES}/specific.bash" ]; then
  source "${SOURCES}/specific.bash"
fi