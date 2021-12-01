#
# Void Linux
#
xbps_install() { sudo xbps-install "$@"; }
xbps_update()  { sudo xbps-install -Su; }
xbps_remove()  { sudo xbps-remove -R "$@"; }
xbps_purge()   { sudo xbps-remove -R "$@" && sudo xbps-remove -Oo; }
xbps_search()  { xbps-query -Rs "$@"; }
xbps_list()    { xbps-query -l; }
xbps_list_files() { xbps-query -Rf "$@"; }
xbps_manual()  {
	xbps-rindex -a *.xbps
	xbps-install --repository=$PWD "$@"
}
xbps_repo_age() { stat -c '%Y' '/var/db/xbps/https___alpha_de_repo_voidlinux_org_current'; }
xbps_repo_update() {
	if ! sudo -n xbps-install -S &> /dev/null; then
		echo "out-of-date"
		exit 1
	fi
}
xbps_num_updates() { xbps-install -nu | wc -l; }
xbps_num_pkgs() { xbps-query -l | wc -l; }