#
# Alpine Linux
#
# WONTFIX:
# piu depends on bash, which isn't in the base install of Alpine.
# Without it, the following error occurs: "-ash: piu: not found"
apk_install() { sudo apk add "$@"; }
apk_update()  { sudo apk upgrade; }
apk_remove()  { sudo apk del "$@"; }
apk_purge()   { sudo apk del "$@" && sudo apk cache clean; }
apk_search()  { apk search -v "$@"; }
apk_list()    { apk info; }
apk_list_files() {
	# WONTFIX:
	# It seems that file content listings are optional with apks, such as
	# with `joe` and`nano`; apk will fail silently with $? as a success.
	apk info -L "$@"
}
apk_manual()  { sudo apk add --allow-untrusted "$@"; }
apk_repo_age() { find /var/cache/apk -type f -print0 | xargs -0 stat -c %Z | sort | tail -1; }
apk_repo_update() {
	if ! sudo -n apk update &> /dev/null; then
		echo "out-of-date"
		exit 1
	fi
}
apk_num_updates() { echo "not implemented yet!" && exit 1; }
apk_num_pkgs() { apk list | wc -l; }
