#
# macOS
#
brew_install() { brew $BREW_CASK install "$@"; }
brew_update()  { brew $BREW_CASK upgrade; }
brew_remove()  { brew $BREW_CASK uninstall "$@"; }
brew_search()  { brew $BREW_CASK search "$@"; }
brew_list()    { brew $BREW_CASK list; }
brew_manual()  { not_implemented; }
brew_purge()   { not_implemented; }
brew_list_files() { not_implemented; }
brew_repo_age() { date +%s; }
brew_repo_update() { brew update; }
brew_num_updates() { not_implemented; }
brew_num_pkgs() { brew_list | wc -l; }
