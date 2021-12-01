#
# Debian / Ubuntu
#
apt_install() { sudo apt install "$@"; }
apt_update()  { sudo apt upgrade; }
apt_remove()  { sudo apt remove "$@"; }
apt_purge()   { sudo apt purge "$@"; }
apt_search()  { apt search "$@"; }
apt_list()    { dpkg-query -f '${binary:Package}\n' -W; }
apt_list_files() {
	if ! apt list --installed 2>/dev/null | grep -q "$@"; then
		# using apt-get prevents dependencies from downloading
		# and doesn't need sudo
		DIR=$(mktemp -d)
		(cd $DIR && apt-get download "$@" > /dev/null 2>&1)
		dpkg -c $DIR/*.deb
	else
		dpkg -L "$@"
	fi
}
apt_manual()  { sudo dpkg -i "$@"; }
apt_repo_age() { stat -c '%Y' '/var/cache/apt/pkgcache.bin'; }
apt_repo_update() {
	if ! sudo -n apt update &> /dev/null; then
		echo 'out-of-date'
		exit 1
	fi
}
apt_num_updates() { apt list --upgradeable 2>/dev/null | tail -n +2 | wc -l; }
apt_num_pkgs() { apt_list | wc -l; }