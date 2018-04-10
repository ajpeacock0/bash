[[ "$-" != *i* ]] && return

SOURCES="/cygdrive/d/git_repos/bash"

# Aliases
# TODO: make these absolute paths
if [ -f "$SOURCES/main.bash" ]; then
  source "$SOURCES/main.bash"
else
	echo "Failed to find the main.bash file in [$SOURCES] :("
fi
