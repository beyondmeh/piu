#
# Arch Linux
#
pacman_install() { sudo pacman -S "$@"; }
pacman_update()  { sudo pacman -Su; }
pacman_remove()  { sudo pacman -Rs "$@"; }
pacman_purge()   { sudo pacman -Rns "$@"; }
pacman_search()  { pacman -Ss "$@"; }
pacman_list()    { pacman -Qqe; }
pacman_list_files() {
	# HELPWANTED:
	# The below code will fail on similar named packages
	# like chromium and chromium-bsu. The problem is two-fold
	#
	# 1. pacman searching needs to use ^PACKAGE$ to match
	# exact names. `pacman -Qs $$@^` doesn't work, but how to
	# properly escape is beyond me.
	#
	# 2. Output from `pacman -Sw` should be captured to get the
	# exact filename of the package. Calling `ls` is sloppy

	if ! pacman -Qs "$@" >/dev/null; then
		sudo pacman -Sw --noconfirm "$@"
		pacman -Qlp $(ls /var/cache/pacman/pkg/$@*)
	else
		pacman -Ql "$@"
	fi
}
pacman_manual()  { sudo pacman -U "$@"; }
pacman_repo_age() { stat -c '%Y' '/var/cache/pacman/pkg'; }
pacman_repo_update() {
	if ! sudo -n pacman -Sy &> /dev/null; then
		echo "out-of-date"
		exit 1
	fi
}
pacman_num_updates() { pacman -Qu | wc -l; }
pacman_num_pkgs() { pacman_list | wc -l; }