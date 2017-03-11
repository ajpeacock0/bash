if [ -f "${HOME}/.bash_aliases_shared" ]; then
  source "${HOME}/.bash_aliases_shared"
fi

if [ -f "${HOME}/.bash_aliases_general" ]; then
  source "${HOME}/.bash_aliases_general"
fi

if [ -f "${HOME}/.bash_aliases_git" ]; then
  source "${HOME}/.bash_aliases_git"
fi

if [ -f "${HOME}/.bash_aliases_android" ]; then
  source "${HOME}/.bash_aliases_android"
fi

if [ -f "${HOME}/.bash_aliases_specific" ]; then
  source "${HOME}/.bash_aliases_specific"
fi
