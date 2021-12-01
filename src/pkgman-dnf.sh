#
# Red Hat / Fedora
#
dnf_install() { sudo dnf install "$@"; }
dnf_update()  { sudo dnf upgrade; }
dnf_remove()  { sudo dnf remove -C "$@"; }
dnf_purge()   {
    # yum / dnf remove works just like apt's purge
    # https://unix.stackexchange.com/questions/8191/what-is-fedoras-equivalent-of-apt-get-purge/8193
    sudo dnf remove "$@"
}
dnf_search()  { dnf search -C "$@"; }
dnf_list()    { dnf list installed -C | awk '{if(NR>1)print $1}'; }
dnf_list_files() { dnf -C repoquery -l "$@"; }
dnf_manual()  { sudo dnf localinstall "$@"; }
dnf_repo_age() { stat -c '%Y' '/var/cache/dnf/packages.db'; }
dnf_repo_update() {
	if ! dnf clean metadata && dnf check-update &> /dev/null; then
		echo 'out-of-date'
		exit 1
	fi
}
dnf_num_updates() { dnf check-update | awk '{if(NR>2)print $1}' | wc -l; }
dnf_num_pkgs() { dnf_list | wc -l; }