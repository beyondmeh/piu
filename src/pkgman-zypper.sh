#
# openSUSE
#
zypper_install() { sudo zypper in "$@"; }
zypper_update()  { sudo zypper up; }
zypper_remove()  { sudo zypper rm -C "$@"; }
zypper_purge()   { sudo zypper rm -u "$@"; }
zypper_search()  { zypper search "$@"; }
zypper_list()    { zypper search -i | grep ^i | awk '{print $3}'; }
zypper_list_files() { dnf -C repoquery -l "$@"; }
zypper_manual()  { sudo zypper in "$@"; }
zypper_repo_age() { stat -c '%Y' '/var/cache/zypp/raw/repo-oss/repodata/repomd.xml'; }
zypper_repo_update() {
	if ! sudo zypper ref &> /dev/null; then
		echo 'out-of-date'
		exit 1
	fi
}
zypper_num_updates() { zypper lu | grep ^v | wc -l; }
zyyper_num_pkgs() { zypper_list | wc -l; }